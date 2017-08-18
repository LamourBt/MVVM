import Foundation


struct ImageItem {
    // imgString should not be mutated
    private let imgString:String
    
    init?(_ dict:[String:Any]?) { // our failable init, make sure that we either get a nil or that imageString
        guard let _dict = dict,
            let imgString = _dict["large_url"] as? String
            else { return nil  }
        self.imgString = imgString
    }
    
    /// return url path from string
    var path:URL {
        return URL(string:self.imgString)!
    }
}
