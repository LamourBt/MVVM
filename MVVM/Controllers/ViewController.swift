import UIKit


final class ViewController: UIViewController {

  // every time, you'll initialize this class 
  // you need to init the viewModel
  public var viewModel:ViewModel!
    
  fileprivate  var imgView:UIImageView!
  fileprivate  var indicator:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setup()
         prepareViewModel()
    }
    
    private func setup() {
        view.backgroundColor = .white
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        imgView = UIImageView(frame:frame )
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.center = view.center
        imgView.center = view.center
        view.addSubview(indicator)
        view.addSubview(imgView)
        
        addingLayoutConstraint(imgView, view)
        centerOutIndicator()
        
        indicator.startAnimating()
    }
    
    private func prepareViewModel() {
        viewModel.datasource = self
        viewModel.initiate()
    }


    
    private func centerOutIndicator() {
        indicator.translatesAutoresizingMaskIntoConstraints = true
        indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }

}
// conforms on our viewModelDataSource
extension ViewController: viewModelDataSource {
    
    func didDownloadImageData(_ imgData: Data) {
        let img = UIImage(data: imgData)
        DispatchQueue.main.async { [weak self ] in
            guard let strongSelf = self else { return }
            strongSelf.indicator.stopAnimating()
            strongSelf.indicator.hidesWhenStopped = true
            strongSelf.indicator.removeFromSuperview()
            strongSelf.imgView.image = img
            strongSelf.imgView.contentMode = .scaleAspectFit
        }
    }
}


extension UIViewController {

     func addingLayoutConstraint( _ childView:UIView, _ parent:UIView) {
        //layout
        childView.translatesAutoresizingMaskIntoConstraints = false
        //pin
        let leading =  childView.leadingAnchor.constraint(equalTo: parent.leadingAnchor)
        let trailing = childView.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
        // align
        childView.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        childView.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        childView.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        // activate
        NSLayoutConstraint.activate([leading, trailing])
    }

}
