import Foundation
import UIKit

@IBDesignable
class DatePickerCell: UITableViewCell {
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.date = Date()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDatePicker()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Cell height
    class func cellHeight() -> CGFloat {
        return 162.0
    }

    func setupDatePicker() {
        addSubview(datePicker)

        datePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
}
