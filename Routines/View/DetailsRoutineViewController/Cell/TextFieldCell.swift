import Foundation
import TinyConstraints
import UIKit

@IBDesignable
class TextFieldCell: UITableViewCell {
    let textField: UITextField = {
        let textField = UITextField()
        return textField
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTextField()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func configure(text: String?, placeholder: String) {
        textField.text = text
        textField.placeholder = placeholder

        textField.accessibilityValue = text
        textField.accessibilityLabel = placeholder
    }

    // Cell height
    class func cellHeight() -> CGFloat {
        return 44.0
    }

    func setupTextField() {
        addSubview(textField)

        textField.edgesToSuperview(insets: UIEdgeInsets(top: 8, left: 20, bottom: 8, right: -20))
    }
}
