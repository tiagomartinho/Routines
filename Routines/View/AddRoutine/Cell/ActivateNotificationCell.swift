import Foundation
import UIKit

@IBDesignable
class ActivateNotificationCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.text = "Activate Routine"
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

        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8).isActive = true
        label.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }

    func setupNotificationSwitch() {
        addSubview(notificationSwitch)

        notificationSwitch.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        notificationSwitch.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8).isActive = true
        notificationSwitch.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8).isActive = true
    }
}
