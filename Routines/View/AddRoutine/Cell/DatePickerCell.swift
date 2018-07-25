import Foundation
import UIKit

@IBDesignable
class DatePickerCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.text = "Choose Date:"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.date = Date()
        datePicker.isHidden = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
        setupDateLabel()
        setupDatePicker()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLabel() {
        addSubview(label)

        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8).isActive = true
        label.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }

    func setupDateLabel() {
        addSubview(dateLabel)

        dateLabel.text = "\(datePicker.date)"

        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }

    func setupDatePicker() {
        addSubview(datePicker)

        datePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8).isActive = true
    }
}
