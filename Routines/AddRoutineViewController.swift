import UIKit
import UserNotifications

class AddRoutineViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view = AddRoutineView(delegate: self)
    }
}

extension AddRoutineViewController: AddRoutineViewDelegate {
    func routineOn() {
        print("routineOn")
    }

    func routineOff() {
        print("routineOff")
    }
}
