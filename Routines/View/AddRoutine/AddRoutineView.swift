import UIKit

@IBDesignable
class AddRoutineView: UIView {
    let notificationSwitch = UISwitch()
    weak var delegate: AddRoutineViewDelegate?

    convenience init(delegate: AddRoutineViewDelegate?) {
        self.init()
        self.delegate = delegate
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        backgroundColor = .white
        notificationSwitch.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
        addSubview(notificationSwitch)
    }

    @objc func switchDidChange(sender: UISwitch) {
        sender.isOn ? delegate?.routineOn() : delegate?.routineOff()
    }

    func setupConstraints() {
        notificationSwitch.translatesAutoresizingMaskIntoConstraints = false
        notificationSwitch.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
    }
}
