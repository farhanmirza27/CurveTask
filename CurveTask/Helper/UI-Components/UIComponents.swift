

import UIKit

/// UIComponents class for reuseablility of UI components with single line
class UIComponents {
    static let shared = UIComponents()
    private init() {}
    
    func label(text : String, textStyle : UIFont.TextStyle = .body, color : UIColor = .black, numberOfLines : Int = 0) -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: textStyle)
        label.numberOfLines = numberOfLines
        label.text = text
        return label
    }
    
    func imageView(imageName : String = "",contentMode : UIView.ContentMode = .scaleAspectFill, clipsToBounds : Bool = false) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = contentMode
        imageView.image = UIImage(named: imageName)
        imageView.clipsToBounds = clipsToBounds
        return imageView
    }
    
    func buttonWithImage(imageName : String, tintColor : UIColor = .black) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = tintColor
        return button
    }
}
