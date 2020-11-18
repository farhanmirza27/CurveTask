

import UIKit
import NVActivityIndicatorView

/// Alert message
extension UIViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

/// Loader / spinner.
extension UIViewController {
    func startAnimating() {
        let activityData = ActivityData(type : .circleStrokeSpin)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func stopAnimating() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
