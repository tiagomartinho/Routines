import UIKit
import UserNotifications

class AddRoutineViewController: UIViewController {
    var scheduler: Scheduler

    init(scheduler: Scheduler) {
        self.scheduler = scheduler
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
        scheduler.schedule()
    }

    func routineOff() {
        print("routineOff")
    }
}
