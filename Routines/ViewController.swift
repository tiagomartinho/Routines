import UIKit

class AddRoutineViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = AddRoutineView { state in
            print(state)
        }
    }
}

class AddRoutineView: UIView {
    
    let notificationSwitch = UISwitch()
    var action: ((Bool)->Void)?
    
    convenience init(action: @escaping (Bool)->Void) {
        self.init()
        self.action = action
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
        action?(sender.isOn)
    }
    
    func setupConstraints() {
        notificationSwitch.translatesAutoresizingMaskIntoConstraints = false
        notificationSwitch.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    }
}
