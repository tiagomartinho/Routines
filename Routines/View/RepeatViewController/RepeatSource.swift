import Foundation
import UIKit

class RepeatSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    let tableView: UITableView
    let delegate: FrequencyDelegate?
    let frequency: Frequency?
    private var lastSelection: IndexPath!

    init(tableView: UITableView, delegate: FrequencyDelegate, frequency: Frequency) {
        self.tableView = tableView
        self.delegate = delegate
        self.frequency = frequency
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
        return Frequency.allValues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView, index: indexPath)
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if lastSelection != nil {
            tableView.cellForRow(at: lastSelection)?.accessoryType = .none
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        lastSelection = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        let frequency = getFrequencyFromIndexPath(index: indexPath)
        delegate?.setFrequency(frequency: frequency)
    }

    private func dequeueCell(in _: UITableView, index indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = "\(getFrequencyFromIndexPath(index: indexPath).rawValue)"
        if frequency == Frequency.allValues[indexPath.row] {
            cell.accessoryType = .checkmark
            lastSelection = indexPath
        }
        return cell
    }

    private func getFrequencyFromIndexPath(index: IndexPath) -> Frequency {
        return Frequency.allValues[index.row]
    }
}
