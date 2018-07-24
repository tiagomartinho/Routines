import UserNotifications

class NotificationScheduler: Scheduler {
    let center: NotificationCenterProtocol

    init(center: NotificationCenterProtocol = UNUserNotificationCenter.current()) {
        self.center = center
    }

    func schedule() {
        let notification = UNMutableNotificationContent()
        notification.title = "My First Notification"
        notification.subtitle = "Study Swift"
        notification.body = "This is the body from my first notification"
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "notification1",
                                            content: notification,
                                            trigger: notificationTrigger)
        center.add(request, withCompletionHandler: nil)
    }
}
