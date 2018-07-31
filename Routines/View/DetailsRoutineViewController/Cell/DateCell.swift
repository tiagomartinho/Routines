import Foundation
import TinyConstraints
import UIKit

@IBDesignable
class DateCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.text = "Alarm"
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        let today = Date()
        label.text = DateHelper.convertDateToString(date: today)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
        setupDateLabel()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Cell height
    class func cellHeight() -> CGFloat {
        return 44.0
    }

    func setLabelText(text: String) {
        dateLabel.text = text
    }

    func setupLabel() {
        addSubview(label)

        label.centerYToSuperview()
        label.leadingToSuperview(offset: 20)
    }

    func setupDateLabel() {
        addSubview(dateLabel)

        dateLabel.centerYToSuperview()
        dateLabel.trailingToSuperview(offset: 20)
    }
}
