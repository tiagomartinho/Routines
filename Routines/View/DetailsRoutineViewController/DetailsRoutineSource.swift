import Foundation
import UIKit

class DetailsRoutineSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    var datePickerIndexPath: IndexPath?
    private var detailsDelegate: DetailsRoutineViewControllerDelegate?
    let tableView: UITableView
    var datePickerDate: Date?
    var alarm: Bool
    var routineName: String?
    var frequency: String? {
        didSet {
            let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 1)) as? FrequencyCell
            cell?.setFrequencyLabelText(text: frequency!)
        }
    }

    init(tableView: UITableView, delegate: DetailsRoutineViewControllerDelegate) {
        self.tableView = tableView
        alarm = false
        super.init()
        detailsDelegate = delegate
        datePickerDate = Date()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlarmCell.self)
        tableView.register(DatePickerCell.self)
        tableView.register(DateCell.self)
        tableView.register(TextFieldCell.self)
        tableView.register(FrequencyCell.self)
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

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = dequeueCell(in: tableView, index: indexPath)
//        return cell
        let cell = DetailsRoutineCellBuilder.build(tableView: tableView, indexPath: indexPath, datePickerIndexPath: datePickerIndexPath, textFieldDelegate: self, datePickerDelegate: self, detailsRoutine: self)
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
            guard let cell = tableView.dequeueReusableCell(TextFieldCell.self) else { return UITableViewCell() }
            cell.configure(text: "", placeholder: "Name")
            cell.textField.delegate = self
            return cell
        } else {
            if datePickerIndexPath == indexPath {
                guard let cell = tableView.dequeueReusableCell(DatePickerCell.self) else { return UITableViewCell() }
                cell.delegate = self
                return cell
            } else if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(AlarmCell.self)!
                cell.notificationSwitch.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCell(DateCell.self) else { return UITableViewCell() }
                cell.isHidden = true
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(FrequencyCell.self)!
                cell.isHidden = true
                return cell
            }
        }
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }

    @objc public func switchDidChange(sender: UISwitch) {
        alarm = sender.isOn ? true : false
        let dateCell = tableView.cellForRow(at: IndexPath(row: 1, section: 1))
        let repeatCell = tableView.cellForRow(at: IndexPath(row: 2, section: 1))
        dateCell?.isHidden = !alarm
        repeatCell?.isHidden = !alarm
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

    func textField(_ textField: UITextField, shouldChangeCharactersIn _: NSRange, replacementString string: String) -> Bool {
        routineName = textField.text
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
