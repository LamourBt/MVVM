

import UIKit

class ViewController: UIViewController,viewModelDelegate {

  fileprivate  var vm:ViewModel!
  fileprivate  var imgView:UIImageView!
  fileprivate  var indicator:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm = ViewModel()
        vm.delegate = self
        
        vm.initiate()
        
        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
        indicator.center = self.view.center
        imgView.center = self.view.center

        self.view.addSubview(indicator)
        self.view.addSubview(imgView)
        
        addLayoutConstraint()
        indicator.startAnimating()
    }

    func didImagesGetDownloaded(imgData: Data) {
          let img = UIImage(data: imgData)
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                self.indicator.removeFromSuperview()
                self.imgView.image = img
                self.imgView.contentMode = .scaleAspectFit
            }
    }
    
    
    func addLayoutConstraint(){
        //layout
        imgView.translatesAutoresizingMaskIntoConstraints = false
        indicator.translatesAutoresizingMaskIntoConstraints = true
        //pin
        let leading =  imgView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailing = imgView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        // align
        imgView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        NSLayoutConstraint.activate([leading, trailing])
    
    }


}

