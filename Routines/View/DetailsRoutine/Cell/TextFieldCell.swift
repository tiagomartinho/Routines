import Foundation
import UIKit

@IBDesignable
class TextFieldCell: UITableViewCell {
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .blue
        return textField
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTextField()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

        textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8).isActive = true
        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8).isActive = true
        textField.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
    }
}
