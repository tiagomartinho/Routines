import UIKit
import UserNotifications

class RepeatViewController: UIViewController {
    lazy var mainView: DetailsRoutineView = DetailsRoutineView()
    var mainSource: RepeatSource?

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainSource = RepeatSource(tableView: mainView.settingsTableView)
    }
}
