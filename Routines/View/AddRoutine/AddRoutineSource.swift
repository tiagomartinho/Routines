import Foundation
import UIKit

class AddRoutineSource: NSObject, UITableViewDelegate, UITableViewDataSource, DatePickerDelegate {
    private let activateNotificationCell = "ActivateNotificationCell"
    private let datePickerCell = "DatePickerCell"
    private let dateCell = "DateCell"

    var datePickerIndexPath: IndexPath?
    let tableView: UITableView
    var datePickerDate: Date?
    weak var delegate: AddRoutineViewDelegate?

    init(tableView: UITableView, delegate: AddRoutineViewDelegate?) {
        self.tableView = tableView
        super.init()
        self.delegate = delegate
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ActivateNotificationCell.self, forCellReuseIdentifier: activateNotificationCell)
        tableView.register(DatePickerCell.self, forCellReuseIdentifier: datePickerCell)
        tableView.register(DateCell.self, forCellReuseIdentifier: dateCell)
    }

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

    internal func didChangeDate(date: Date) {
        let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? DateCell
        cell?.setLabelText(text: DateHelper.convertDateToString(date: date))
        datePickerDate = date
    }
}
