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
        mainSource = DetailsRoutineSource(tableView: mainView.settingsTableView, delegate: self)
        navigationItem.title = "Routine"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
    }

    @objc func doneTapped() {
        guard let routineName = mainSource?.routineName else {
            fatalError()
        }
        guard let alarm = mainSource?.alarm else {
            fatalError()
        }
        guard let date = mainSource?.datePickerDate else {
            fatalError()
        }
        let routine = Routine(name: routineName, alarm: alarm, date: date)
        if alarm {
            createNotificaton(on: date)
        }
        // save routine
    }

    func createNotificaton(on: Date) {
        notificationScheduler.createNotificationOnDate(date: on)
        notificationScheduler.getAllNotifications()
    }

    func routineOff() {
        print("routineOff")
    }
}

extension DetailsRoutineViewController: DetailsRoutineViewControllerDelegate {
    func routeToRepeatViewController() {
        navigationController?.pushViewController(RepeatViewController(), animated: true)
    }
}
