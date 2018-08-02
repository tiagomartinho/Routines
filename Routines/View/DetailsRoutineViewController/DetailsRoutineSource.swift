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

    private var sections = [Section]()

    init(tableView: UITableView, delegate: DetailsRoutineViewControllerDelegate) {
        self.tableView = tableView
        alarm = false
        super.init()
        detailsDelegate = delegate
        datePickerDate = Date()
        initSections()
        initTableView()
    }

    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlarmCell.self)
        tableView.register(DatePickerCell.self)
        tableView.register(DateCell.self)
        tableView.register(TextFieldCell.self)
        tableView.register(FrequencyCell.self)
    }

    private func initSections() {
        if datePickerIndexPath != nil {
            sections = [
                Section(type: .General, items: [.Name]),
                Section(type: .Alarm, items: [.AlarmSwitch, .AlarmDate, .DatePicker, .Frequency]),
            ]
        } else {
            sections = [
                Section(type: .General, items: [.Name]),
                Section(type: .Alarm, items: [.AlarmSwitch, .AlarmDate, .Frequency]),
            ]
        }
    }

    func tableView(_: UITableView,
                   titleForHeaderInSection _: Int) -> String? {
        return " "
    }

    func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DetailsRoutineCellBuilder.build(tableView: tableView, sections: sections, indexPath: indexPath, datePickerIndexPath: datePickerIndexPath, textFieldDelegate: self, datePickerDelegate: self, detailsRoutine: self)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        switch sections[indexPath.section].items[indexPath.row] {
        case .AlarmDate:
            if datePickerIndexPath != nil {
                sections[1].items.remove(at: 2)
                tableView.deleteRows(at: [datePickerIndexPath!], with: .fade)
                datePickerIndexPath = nil
            } else {
                datePickerIndexPath = indexPathToInsertDatePicker(indexPath: indexPath)
                tableView.insertRows(at: [datePickerIndexPath!], with: .fade)
                sections[1].items.insert(.DatePicker, at: 2)
                tableView.deselectRow(at: indexPath, animated: true)
            }

        case .Frequency:
            detailsDelegate?.routeToRepeatViewController()
        default:
            break
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
        if routineName!.count > 0 {
            detailsDelegate?.changeStatusDoneButton(status: true)
        } else {
            detailsDelegate?.changeStatusDoneButton(status: false)
        }
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
        if routineName!.count > 0 {
            detailsDelegate?.changeStatusDoneButton(status: true)
        } else {
            detailsDelegate?.changeStatusDoneButton(status: false)
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
