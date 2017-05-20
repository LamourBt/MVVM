import Foundation


struct ImageStructure {
    private let imgString:String
    
    init(fromDictionary dict:Dictionary<String, Any>?) {
        guard let _dict = dict,
            let imgString = _dict["large_url"] as? String
            else { fatalError()  }
        self.imgString = imgString
    }
    /// return url path from string
    func path()-> URL {
        return URL(string:self.imgString)!
    }
}
