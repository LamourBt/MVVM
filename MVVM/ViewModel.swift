
import Foundation
import UIKit

protocol viewModelDelegate: class {
    func didImagesGetDownloaded(imgData:Data)
}

class ViewModel {

   fileprivate let endpointString = "http://www.splashbase.co/api/v1/images/1"
   fileprivate var model:Model!
   public weak var delegate:viewModelDelegate?
    
    init() {
        let endpointUrl = URL(string: endpointString)
        guard let end = endpointUrl else { fatalError() }
        model = Model(withUrl: end )
    }
      
    func initiate() {
        model?.downloadDict(completion: { (dict:Dictionary<String,Any>?) in
            if dict != nil {
                guard let _dict = dict,
                    let imgString = _dict["large_url"] as? String,
                    let imgUrl = URL(string:imgString)
                    else { fatalError()  }
                self.model.downLoadImage(withURL: imgUrl, completion: { (imgData:Data) in
                    self.delegate?.didImagesGetDownloaded(imgData: imgData)
                })
            }
       })
    }

}
