import Foundation
import UIKit

@IBDesignable
class DatePickerCell: UITableViewCell {
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.date = Date()
        return datePicker
    }()

    weak var delegate: DatePickerDelegate?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDatePicker()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Cell height
    class func cellHeight() -> CGFloat {
        return 216
    }

    func setupDatePicker() {
        addSubview(datePicker)

        datePicker.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)

        datePicker.edgesToSuperview()
    }

    @objc func dateDidChange(_ sender: UIDatePicker) {
        delegate?.didChangeDate(date: sender.date)
    }
}
