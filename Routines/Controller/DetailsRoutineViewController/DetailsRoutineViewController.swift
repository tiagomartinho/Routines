import UIKit
import UserNotifications

class DetailsRoutineViewController: UIViewController {
    var notificationScheduler: NotificationScheduler
    lazy var mainView: DetailsRoutineView = DetailsRoutineView()
    var mainSource: DetailsRoutineSource?
    var frequency: Frequency

    init(scheduler: NotificationScheduler) {
        notificationScheduler = scheduler
        frequency = Frequency.never
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
        guard let routineName = mainSource?.routineName else { fatalError() }
        guard let date = mainSource?.datePickerDate else { fatalError() }
        let alarm = mainSource?.alarm
        let routine = Routine(name: routineName, alarm: alarm!, date: date, frequency: frequency)
        if alarm! {
            createNotificaton(id: routine.getId(), name: routineName, on: date, frequency: frequency)
        }
        // save routine
    }

    func createNotificaton(id: String, name: String, on date: Date, frequency: Frequency?) {
        notificationScheduler.createNotificationOnDate(id: id, name: name, date: date, frequency: frequency)
        notificationScheduler.getAllNotifications()
    }

    func routineOff() {
        print("routineOff")
    }
}

extension DetailsRoutineViewController: DetailsRoutineViewControllerDelegate {
    func routeToRepeatViewController() {
        navigationController?.pushViewController(RepeatViewController(delegate: self, frequency: frequency), animated: true)
    }
}

extension DetailsRoutineViewController: FrequencyDelegate {
    func setFrequency(frequency: Frequency) {
        print(frequency)
        self.frequency = frequency
        mainSource?.frequency = self.frequency.rawValue
    }
}
