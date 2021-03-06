import Foundation
import UIKit

@IBDesignable
class AlarmCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.text = "Remind me on a day"
        return label
    }()

    let notificationSwitch: UISwitch = {
        let notificationSwitch = UISwitch()
        notificationSwitch.translatesAutoresizingMaskIntoConstraints = false
        return notificationSwitch
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
        setupNotificationSwitch()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupLabel() {
        addSubview(label)

        label.centerYToSuperview()
        label.leadingToSuperview(offset: 20)
    }

    func setupNotificationSwitch() {
        addSubview(notificationSwitch)

        notificationSwitch.centerYToSuperview()
        notificationSwitch.trailingToSuperview(offset: 20)
    }
}
