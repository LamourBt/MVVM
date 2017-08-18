
import Foundation
import UIKit

class App {
    private let window:UIWindow!
    
    init?(withWindow wind:UIWindow?) {
      guard let _wind = wind else { return nil }
      window = _wind
    }
    
    func coordinate() {
       let vc = ViewController()
        vc.viewModel = ViewModel(Model(withUrl: URL(string:Constant.apiEndpoint)!))
        window.rootViewController = vc
    }
}


struct Constant {
    static let apiEndpoint = "http://www.splashbase.co/api/v1/images/1"
}
