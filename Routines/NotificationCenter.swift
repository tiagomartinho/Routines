import UserNotifications

protocol NotificationCenterProtocol {
    func add(_ request: UNNotificationRequest, withCompletionHandler completionHandler: ((Error?) -> Swift.Void)?)
}

extension UNUserNotificationCenter: NotificationCenterProtocol {
}
