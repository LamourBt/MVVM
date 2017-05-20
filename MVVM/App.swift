
import Foundation
import UIKit

class App {
    private let window:UIWindow!
    
    init(withWindow wind:UIWindow?) {
      guard let _wind = wind else { fatalError() }
      self.window = _wind
    }
    
    func coordinate() {
       let vc = ViewController()
       vc.vm = ViewModel()
       self.window.rootViewController = vc 
    
    }
}
