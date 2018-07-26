import Foundation
import UIKit

@IBDesignable
class DateCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.text = "Alarm"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
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

        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8).isActive = true
    }

    func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8).isActive = true
    }
}
