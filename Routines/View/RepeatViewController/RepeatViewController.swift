import UIKit
import UserNotifications

class RepeatViewController: UIViewController {
    lazy var mainView: DetailsRoutineView = DetailsRoutineView()
    var mainSource: RepeatSource?
    var delegate: FrequencyDelegate?
    var frequency: Frequency

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainSource = RepeatSource(tableView: mainView.settingsTableView, delegate: delegate!, frequency: frequency)
    }

    init(delegate: FrequencyDelegate, frequency: Frequency) {
        self.delegate = delegate
        self.frequency = frequency
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
