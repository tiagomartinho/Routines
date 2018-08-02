import UIKit
import UserNotifications

class DetailsRoutineViewController: UIViewController {
    lazy var mainView: DetailsRoutineView = DetailsRoutineView()
    var mainSource: DetailsRoutineSource?
    var frequency: Frequency
    var presenter: DetailsRoutinePresenter!

    init(presenter: DetailsRoutinePresenter) {
        self.presenter = presenter
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
        navigationItem.rightBarButtonItem?.isEnabled = false
    }

    @objc func doneTapped() {
        guard let routineName = mainSource?.routineName else { fatalError() }
        guard let date = mainSource?.datePickerDate else { fatalError() }
        let alarm = mainSource?.alarm
        presenter.createRoutine(name: routineName, alarm: alarm!, date: date, frequency: frequency)
    }

    func routineOff() {
        print("routineOff")
    }
}

extension DetailsRoutineViewController: DetailsRoutineViewControllerDelegate {
    func changeStatusDoneButton(status: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = status
    }

    func routeToRepeatViewController() {
        navigationController?.pushViewController(RepeatViewController(delegate: self, frequency: frequency), animated: true)
    }
}

extension DetailsRoutineViewController: FrequencyDelegate {
    func setFrequency(frequency: Frequency) {
        self.frequency = frequency
        mainSource?.frequency = self.frequency.rawValue
    }
}
