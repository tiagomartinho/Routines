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
    }
}

extension AddRoutineViewController: AddRoutineViewDelegate {
    func routineOn() {
        print("turnOn")
        notificationScheduler.schedule()
        notificationScheduler.createNotificationOnDate()
    }

    func routineOff() {
        print("routineOff")
    }
}
