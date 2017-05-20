import Foundation
import UIKit

protocol viewModelDelegate: class {
    func didImagesGetDownloaded(imgData:Data)
}


class ViewModel {
    
    fileprivate let endpointString = "http://www.splashbase.co/api/v1/images/1"
    fileprivate let model:Model!
    public weak var delegate:viewModelDelegate?
    
    init() {
        guard let end = URL(string: endpointString)
            else { fatalError() }
        model = Model(withUrl: end )
        
    }
    /// initiate: would get data from api then raise the delegate 
    func initiate() {
        model?.downloadDict() { [weak self] dict in
            self?.model.downLoadImage(withURL: ImageStructure(fromDictionary: dict).path()){ imgData in
                self?.delegate?.didImagesGetDownloaded(imgData: imgData)
            }
        }
    }
    
}
