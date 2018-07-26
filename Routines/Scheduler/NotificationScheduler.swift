import UserNotifications

class NotificationScheduler: NotificationSchedulerProtocol {
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
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: notification,
                                            trigger: notificationTrigger)
        center.add(request, withCompletionHandler: nil)
    }

    func createNotificationOnDate(date: Date) {
        let notification = UNMutableNotificationContent()
        notification.title = "My First Notification"
        notification.subtitle = "Study Swift"
        notification.body = "This is the notification create at \(date)"
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,
                                                                repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: notification,
                                            trigger: notificationTrigger)
        center.add(request, withCompletionHandler: nil)
    }
}
