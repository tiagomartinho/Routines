import UIKit
import UserNotifications

class DetailsRoutineViewController: UIViewController {
    var notificationScheduler: NotificationScheduler
    lazy var mainView: DetailsRoutineView = DetailsRoutineView()
    var mainSource: DetailsRoutineSource?

    init(scheduler: NotificationScheduler) {
        notificationScheduler = scheduler
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainSource = DetailsRoutineSource(tableView: mainView.settingsTableView)
        navigationItem.title = "Routine"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
    }

    @objc func doneTapped() {
        print("done tapped")
    }
}

extension DetailsRoutineViewController: DetailsRoutineViewDelegate {
    func routineOn(date: Date) {
        notificationScheduler.createNotificationOnDate(date: date)
        notificationScheduler.getAllNotifications()
    }

    func routineOff() {
        print("routineOff")
    }
}
