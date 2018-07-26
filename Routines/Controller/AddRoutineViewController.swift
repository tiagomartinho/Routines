import UIKit
import UserNotifications

class AddRoutineViewController: UIViewController {
    var notificationScheduler: NotificationScheduler

    init(scheduler: NotificationScheduler) {
        notificationScheduler = scheduler
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = AddRoutineView(delegate: self)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Create Routine"
    }
}

extension AddRoutineViewController: AddRoutineViewDelegate {
    func routineOn(date: Date) {
        print(date)
//        notificationScheduler.schedule()
//        notificationScheduler.createNotificationOnDate()
        notificationScheduler.createNotificationOnDate(date: date)
    }

    func routineOff() {
        print("routineOff")
    }
}
