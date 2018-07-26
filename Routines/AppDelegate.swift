import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let scheduler = NotificationScheduler()
        initNotificationSetupCheck()
        let addRoutineViewController = AddRoutineViewController(scheduler: scheduler)
        window?.rootViewController = UINavigationController(rootViewController: addRoutineViewController)
        window?.makeKeyAndVisible()
        return true
    }

    func initNotificationSetupCheck() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { success, _ in
            if success {
                print("Permission Granted")
            } else {
                print("There was a problem!")
            }
        }
    }
}
