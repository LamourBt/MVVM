import Foundation
import UIKit

protocol viewModelDataSource: class {
    func didDownloadImageData(_ imgData:Data)
}


class ViewModel {
    
    private let model:Model!
    public weak var datasource:viewModelDataSource?
    
    init(_ model:Model) {
        self.model = model
    }
    
    /// initiate: would get data from api then raise the delegate 
    public func initiate() {
        model?.downloadDict() { [weak self] dict in
            guard let strong = self,
                    let item = ImageItem(dict)
                    else { return }
            
            strong.model.downLoadImage(withURL: item.path) { imgData in
                  strong.datasource?.didDownloadImageData(imgData)
               }
        }
    }
    
}
