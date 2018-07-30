import Foundation
import UIKit

@IBDesignable
class ActivateNotificationCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.text = "Remind me on a day"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
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

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLabel() {
        addSubview(label)

        label.centerYToSuperview()
        label.leadingToSuperview(offset: 8)
    }

    func setupNotificationSwitch() {
        addSubview(notificationSwitch)

        notificationSwitch.centerYToSuperview()
        notificationSwitch.trailingToSuperview(offset: 8)
    }
}
