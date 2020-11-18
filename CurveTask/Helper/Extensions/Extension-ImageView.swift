

import Foundation
import Kingfisher

/// UIImageView extension for loading images via URL using Kingfiher pod..
extension UIImageView {
    func cacheImage(imageUrl: String?) {
        if let imageUrl = imageUrl {
            let url = URL(string: imageUrl)
            let placeholderImage = UIImage(named: "placeholder")
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url, placeholder: placeholderImage)
        }
    }
}
