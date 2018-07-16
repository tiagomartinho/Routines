import UserNotifications

protocol NotifcationCenter {
    func add(_ request: UNNotificationRequest, withCompletionHandler completionHandler: ((Error?) -> Swift.Void)?)
}

extension UNUserNotificationCenter: NotifcationCenter {
}
