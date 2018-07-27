import UIKit

@IBDesignable
class DetailsRoutineView: UIView {
    let settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = UIColor(red: 243.0 / 255, green: 243.0 / 255, blue: 243.0 / 255, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSettingsTableView()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSettingsTableView() {
        addSubview(settingsTableView)

        settingsTableView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        settingsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        settingsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }
}
