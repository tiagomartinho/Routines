import Foundation
import TinyConstraints
import UIKit

@IBDesignable
class RepeatCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.text = "Repeat"
        return label
    }()

    let frequencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Never"
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
        setupFrequencyLabel()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Cell height
    class func cellHeight() -> CGFloat {
        return 44.0
    }

    func setFrequencyLabelText(text: String) {
        frequencyLabel.text = text
    }

    func setupLabel() {
        addSubview(label)

        label.centerYToSuperview()
        label.leadingToSuperview(offset: 20)
    }

    func setupFrequencyLabel() {
        addSubview(frequencyLabel)

        frequencyLabel.centerYToSuperview()
        frequencyLabel.trailingToSuperview(offset: 20)
    }
}
