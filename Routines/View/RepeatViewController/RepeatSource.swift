import Foundation
import UIKit

class RepeatSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    let tableView: UITableView
    let delegate: FrequencyDelegate?

    init(tableView: UITableView, delegate: FrequencyDelegate) {
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_: UITableView,
                   titleForHeaderInSection _: Int) -> String? {
        return " "
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView, index: indexPath)
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            delegate?.setFrequency(frequency: Frequency.day)
        case 1:
            delegate?.setFrequency(frequency: Frequency.week)
        case 2:
            delegate?.setFrequency(frequency: Frequency.month)
        case 3:
            delegate?.setFrequency(frequency: Frequency.year)
        default:
            delegate?.setFrequency(frequency: Frequency.day)
        }
    }

    private func dequeueCell(in _: UITableView, index index: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        switch index.row {
        case 0:
            cell.textLabel!.text = "Every \(Frequency.day.rawValue)"
        case 1:
            cell.textLabel!.text = "Every \(Frequency.week.rawValue)"
        case 2:
            cell.textLabel!.text = "Every \(Frequency.month.rawValue)"
        case 3:
            cell.textLabel!.text = "Every \(Frequency.year.rawValue)"
        default:
            cell.textLabel!.text = ""
        }
        return cell
    }
}
