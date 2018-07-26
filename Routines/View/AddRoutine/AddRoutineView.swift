import UIKit

@IBDesignable
class AddRoutineView: UIView {
    private let activateNotificationCell = "ActivateNotificationCell"
    private let datePickerCell = "DatePickerCell"
    private let dateCell = "DateCell"

    var datePickerIndexPath: IndexPath?
    var datePickerDate: Date?

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
        settingsTableView.register(DateCell.self, forCellReuseIdentifier: dateCell)

        settingsTableView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        settingsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        settingsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }
}

extension AddRoutineView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView,
                   titleForHeaderInSection _: Int) -> String? {
        return " "
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if datePickerIndexPath != nil {
            return 3
        } else {
            return 2
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView, index: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row - 1 == indexPath.row {
            tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            self.datePickerIndexPath = nil
        } else {
            if indexPath.row == 1 {
                datePickerIndexPath = indexPathToInsertDatePicker(indexPath: indexPath)
                tableView.insertRows(at: [datePickerIndexPath!], with: .fade)
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        tableView.endUpdates()
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerIndexPath == indexPath {
            return DatePickerCell.cellHeight()
        } else {
            return DateCell.cellHeight()
        }
    }

    private func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
        if let datePickerIndexPath = datePickerIndexPath,
            datePickerIndexPath.row < indexPath.row {
            return indexPath
        } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
    }

    private func dequeueCell(in tableView: UITableView, index indexPath: IndexPath) -> UITableViewCell {
        if datePickerIndexPath == indexPath {
            guard let datePickerCell = tableView.dequeueReusableCell(withIdentifier: datePickerCell) as? DatePickerCell else {
                return UITableViewCell()
            }
            datePickerCell.delegate = self
            return datePickerCell
        } else if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: activateNotificationCell) as? ActivateNotificationCell else {
                return UITableViewCell()
            }
            cell.notificationSwitch.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: dateCell) as? DateCell else {
                return UITableViewCell()
            }
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }

    @objc private func switchDidChange(sender: UISwitch) {
        let date = datePickerDate != nil ? datePickerDate! : Date()
        sender.isOn ? delegate?.routineOn(date: date) : delegate?.routineOff()
    }
}

extension AddRoutineView: DatePickerDelegate {
    func didChangeDate(date: Date) {
        let cell = settingsTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? DateCell
        cell?.setLabelText(text: DateHelper.convertDateToString(date: date))
        datePickerDate = date
    }
}
