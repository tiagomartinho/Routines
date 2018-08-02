@testable import Routines
import UserNotifications
import XCTest

class DetailsRoutinePresenterTest: XCTestCase {
    func test_AddNotificationToCenter_WhenCreateNotification() {
        let center = SpyNotificationCenter()
        let notificationScheduler = NotificationScheduler(center: center)
        let repository = SpyRepository()

        let sut = makeSUT(notificationScheduler, repository)
        sut.createRoutine(name: "Teste", alarm: true, date: Date(), frequency: .never)

        XCTAssert(center.addCalled)
    }

    func test_SaveRoutine_WhenCreateNotification() {
        let center = SpyNotificationCenter()
        let notificationScheduler = NotificationScheduler(center: center)
        let repository = SpyRepository()

        let sut = makeSUT(notificationScheduler, repository)
        sut.createRoutine(name: "Teste", alarm: true, date: Date(), frequency: .never)

        XCTAssert(repository.saveFired)
    }

    // MARK: Helpers

    func makeSUT(_ center: NotificationScheduler, _ repository: RoutineRepository) -> DetailsRoutinePresenter {
        return DetailsRoutinePresenter(notificationScheduler: center, repository: repository)
    }
}

class SpyNotificationCenter: NotificationCenterProtocol {
    var addCalled = false

    func add(_: UNNotificationRequest, withCompletionHandler _: ((Error?) -> Swift.Void)?) {
        addCalled = true
    }
}

class SpyRepository: RoutineRepository {
    var saveFired = false
    var getAllFired = false

    func save(_: Routine) {
        saveFired = true
    }

    func getAll() -> [Routine] {
        getAllFired = true
        return [Routine]()
    }
}
