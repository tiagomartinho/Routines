import UserNotifications

class NotificationScheduler {
    
    let center: NotifcationCenter
    
    init(center: NotifcationCenter = UNUserNotificationCenter.current()) {
        self.center = center
    }
    
    func schedule() {
        let content = UNMutableNotificationContent()
        content.body = "Hello"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request) { (error) in
            print(error)
        }
    }
}
