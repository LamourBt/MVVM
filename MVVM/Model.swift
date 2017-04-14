import Foundation
import UIKit




struct Model {
    
    var endpoint:URL!
    init(withUrl url:URL) {
       endpoint = url
    }
    
    fileprivate func download(url:URL,completion:@escaping(Data) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: url) { (data:Data?, res:URLResponse?, err:Error?) in
            if (err == nil) {
                guard let response = res as? HTTPURLResponse else { fatalError() }
                if response.statusCode == 200 {
                    guard let imageData = data else { fatalError() }
                    completion(imageData)
                }
            }
            }.resume()
    }

    func downloadDict(completion:@escaping(Dictionary<String,Any>?)-> Void) {
        download(url: endpoint) { (imgData:Data) in
            guard let jsonData = try? JSONSerialization.jsonObject(with: imgData, options: []) as? Dictionary<String,Any>  else { fatalError() }
            completion(jsonData)
        }
    }
    
    func downLoadImage(withURL epoint:URL ,completion:@escaping(Data)-> Void) {
        download(url: epoint) { (imgData:Data) in
            completion(imgData)
        }
    }

}
