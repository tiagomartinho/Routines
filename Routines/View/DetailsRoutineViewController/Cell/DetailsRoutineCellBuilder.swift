import UIKit

class DetailsRoutineCellBuilder {
    static func build(tableView: UITableView, indexPath: IndexPath, datePickerIndexPath: IndexPath?, textFieldDelegate: UITextFieldDelegate, datePickerDelegate: DatePickerDelegate, detailsRoutine: DetailsRoutineSource) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(TextFieldCell.self) else { return UITableViewCell() }
            cell.configure(text: "", placeholder: "Name")
            cell.textField.delegate = textFieldDelegate
            return cell
        } else {
            if datePickerIndexPath == indexPath {
                guard let cell = tableView.dequeueReusableCell(DatePickerCell.self) else { return UITableViewCell() }
                cell.delegate = datePickerDelegate
                return cell
            } else if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(AlarmCell.self)!
                cell.notificationSwitch.addTarget(detailsRoutine, action: #selector(detailsRoutine.switchDidChange), for: .valueChanged)
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
}
