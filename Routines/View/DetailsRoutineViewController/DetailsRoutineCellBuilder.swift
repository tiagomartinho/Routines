import UIKit

class DetailsRoutineCellBuilder {
    static func build(tableView: UITableView, sections: [Section], indexPath: IndexPath, datePickerIndexPath _: IndexPath?, textFieldDelegate: UITextFieldDelegate, datePickerDelegate: DatePickerDelegate, detailsRoutine: DetailsRoutineSource) -> UITableViewCell {
        switch sections[indexPath.section].items[indexPath.row] {
        case .Name:
            guard let cell = tableView.dequeueReusableCell(TextFieldCell.self) else { return UITableViewCell() }
            cell.configure(text: "", placeholder: "Name")
            cell.textField.delegate = textFieldDelegate
            return cell

        case .AlarmSwitch:
            let cell = tableView.dequeueReusableCell(AlarmCell.self)!
            cell.notificationSwitch.addTarget(detailsRoutine, action: #selector(detailsRoutine.switchDidChange), for: .valueChanged)
            cell.selectionStyle = .none
            return cell

        case .AlarmDate:
            guard let cell = tableView.dequeueReusableCell(DateCell.self) else { return UITableViewCell() }
            cell.isHidden = true
            return cell

        case .DatePicker:
            guard let cell = tableView.dequeueReusableCell(DatePickerCell.self) else { return UITableViewCell() }
            cell.delegate = datePickerDelegate
            return cell

        case .Frequency:
            let cell = tableView.dequeueReusableCell(FrequencyCell.self)!
            cell.isHidden = true
            return cell
        }
    }
}
