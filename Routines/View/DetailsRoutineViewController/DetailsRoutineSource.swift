import Foundation
import UIKit

class DetailsRoutineSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    private let activateNotificationCell = "ActivateNotificationCell"
    private let datePickerCell = "DatePickerCell"
    private let dateCell = "DateCell"
    private let textFieldCell = "TextFieldCell"

    private var datePickerIndexPath: IndexPath?
    private var detailsDelegate: DetailsRoutineViewControllerDelegate?
    let tableView: UITableView
    var datePickerDate: Date?
    var alarm: Bool?
    var routineName: String?

    init(tableView: UITableView, delegate: DetailsRoutineViewControllerDelegate) {
        self.tableView = tableView
        super.init()
        detailsDelegate = delegate
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ActivateNotificationCell.self, forCellReuseIdentifier: activateNotificationCell)
        tableView.register(DatePickerCell.self, forCellReuseIdentifier: datePickerCell)
        tableView.register(DateCell.self, forCellReuseIdentifier: dateCell)
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: textFieldCell)
    }

    func tableView(_: UITableView,
                   titleForHeaderInSection _: Int) -> String? {
        return " "
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 2
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if datePickerIndexPath != nil {
                return 4
            } else {
                return 3
            }
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
            if indexPath.row == 2 {
                detailsDelegate?.routeToRepeatViewController()
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
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCell) as? TextFieldCell else {
                return UITableViewCell()
            }
            cell.configure(text: "", placeholder: "Name")
            cell.textField.delegate = self
            return cell
        } else {
            if datePickerIndexPath == indexPath {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: datePickerCell) as? DatePickerCell else {
                    return UITableViewCell()
                }
                cell.delegate = self
                return cell
            } else if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: activateNotificationCell) as? ActivateNotificationCell else {
                    return UITableViewCell()
                }
                cell.notificationSwitch.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: dateCell) as? DateCell else {
                    return UITableViewCell()
                }
                return cell
            } else if indexPath.row == 2 {
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
                cell.textLabel!.text = "Repeat"
                cell.accessoryType = .disclosureIndicator
                return cell
            }
        }
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }

    @objc private func switchDidChange(sender: UISwitch) {
        alarm = sender.isOn ? true : false
    }
}

extension DetailsRoutineSource: DatePickerDelegate {
    internal func didChangeDate(date: Date) {
        let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 1)) as? DateCell
        cell?.setLabelText(text: DateHelper.convertDateToString(date: date))
        datePickerDate = date
    }
}

extension DetailsRoutineSource: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        routineName = textField.text
    }

    func textFieldShouldBeginEditing(_: UITextField) -> Bool {
        return true
    }

    func textFieldShouldClear(_: UITextField) -> Bool {
        return true
    }

    func textFieldShouldEndEditing(_: UITextField) -> Bool {
        return true
    }

    func textField(_: UITextField, shouldChangeCharactersIn _: NSRange, replacementString _: String) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
