import UIKit

@IBDesignable
class AddRoutineView: UIView {
    private let activateNotificationCell = "ActivateNotificationCell"
    private let datePickerCell = "DatePickerCell"

    let settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = UIColor(red: 243.0 / 255, green: 243.0 / 255, blue: 243.0 / 255, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    weak var delegate: AddRoutineViewDelegate?

    convenience init(delegate: AddRoutineViewDelegate?) {
        self.init()
        self.delegate = delegate
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSettingsTableView()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSettingsTableView() {
        addSubview(settingsTableView)

        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(ActivateNotificationCell.self, forCellReuseIdentifier: activateNotificationCell)
        settingsTableView.register(DatePickerCell.self, forCellReuseIdentifier: datePickerCell)

        settingsTableView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        settingsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        settingsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }
}

extension AddRoutineView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView, index: indexPath)
        return cell
    }

    func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
        return 80
    }

    private func dequeueCell(in tableView: UITableView, index indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: activateNotificationCell) as? ActivateNotificationCell {
                cell.notificationSwitch.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
                return cell
            }
        } else if indexPath.row == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: datePickerCell) as? DatePickerCell {
                return cell
            }
        }
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }

    @objc private func switchDidChange(sender: UISwitch) {
        sender.isOn ? delegate?.routineOn() : delegate?.routineOff()
    }
}
