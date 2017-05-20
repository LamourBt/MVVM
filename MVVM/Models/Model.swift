import Foundation
import UIKit

enum Request<T> {
    case success(T)
    case failure(Error)
}

struct Model {
    typealias ResponseHandler = (Data)->()
    typealias RequestHandler  = (Request<Data>)->()
    
    
    private let endpoint:URL!
    
    init(withUrl url:URL) {
        self.endpoint = url
    }
    
    
    fileprivate func downloadTask(url:URL,completion: @escaping RequestHandler) {
        
        URLSession.shared.dataTask(with: url) { (data:Data?, res:URLResponse?, err:Error?) in
            if (err == nil) {
                guard let response = res as? HTTPURLResponse else { fatalError() }
                // also could switch on status, and show error case
                if response.statusCode == 200 {
                    guard let imageData = data else { fatalError() }
                    completion(.success(imageData))
                }
            } else {
                if let er = err {
                    completion(.failure(er))
                }
            }
            }.resume()
    }
    
    
    func downloadDict(completion:@escaping(Dictionary<String,Any>?)-> Void) {
        
        downloadTask(url: self.endpoint) { request in
            switch request {
            case .success(let imgData):
                // use try and catch instead of try?
                guard let jsonData = try? JSONSerialization.jsonObject(with: imgData, options: []) as? Dictionary<String,Any>  else { fatalError() } // jsonData was of type ??
                completion(jsonData)
            case .failure(_):
                break
            }
        }
    }
    
    func downLoadImage(withURL route:URL ,completion:@escaping ResponseHandler) {
        
        downloadTask(url:route) { request in
            switch request {
            case .success(let imgData):
                // use try and catch instead of try?
                completion(imgData)
            case .failure(_):
                break
            }
        }
        
    }
    
}
