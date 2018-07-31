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

    func getAllNotifications() {
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests(completionHandler: { requests in
            for request in requests {
                print(request)
            }
        })
    }

    func createNotificationOnDate(id: String, date: Date, frequency: Frequency?) {
        let notification = UNMutableNotificationContent()
        notification.title = "My First Notification"
        notification.subtitle = "Study Swift"
        notification.body = "This is the notification create at \(date)"
        let dateComponents = dateComponentsBuilder(frequency: frequency)
        let triggerDate = Calendar.current.dateComponents(dateComponents, from: date)
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,
                                                                repeats: true)
        let request = UNNotificationRequest(identifier: id,
                                            content: notification,
                                            trigger: notificationTrigger)
        center.add(request, withCompletionHandler: nil)
    }

    func dateComponentsBuilder(frequency: Frequency?) -> Set<Calendar.Component> {
        switch frequency {
        case .day?:
            return [.hour, .minute, .second]
        case .week?:
            return [.year, .month, .day, .hour, .minute, .second]
        case .month?:
            return [.day, .hour, .minute, .second]
        case .year?:
            return [.month, .day, .hour, .minute, .second]
        default:
            return [.year, .month, .day, .hour, .minute, .second]
        }
    }
}
