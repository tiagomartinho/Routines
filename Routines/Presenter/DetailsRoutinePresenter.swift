import Foundation

class DetailsRoutinePresenter {
    private var notificationScheduler: NotificationScheduler
    private var repository: RoutineRepository

    public init(notificationScheduler: NotificationScheduler,
                repository: RoutineRepository) {
        self.notificationScheduler = notificationScheduler
        self.repository = repository
    }

    func createRoutine(name: String, alarm: Bool, date: Date, frequency: Frequency) {
        let routine = Routine(name: name, alarm: alarm, date: date, frequency: frequency)
        if alarm {
            createNotificaton(id: routine.id, name: name, on: date, frequency: frequency)
        }
        repository.save(routine)
    }

    private func createNotificaton(id: String, name: String, on date: Date, frequency: Frequency?) {
        notificationScheduler.createNotificationOnDate(id: id, name: name, date: date, frequency: frequency)
        notificationScheduler.getAllNotifications()
    }
}
