

import UIKit

/// add subviews for autolayout...
extension UIView {
    func addSubViews(views : UIView...) {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
