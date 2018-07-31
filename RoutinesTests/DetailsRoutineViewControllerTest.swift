@testable import Routines
import UserNotifications
import XCTest

class DetailsRoutineViewControllerTest: XCTestCase {
    func test_ensureSchedulerAddsRequestToCenter() {
        let center = SpyNotificationCenter()
        let sut = makeSUT(center)
    }

    // MARK: Helpers

    func makeSUT(_ center: NotificationCenterProtocol) -> DetailsRoutineViewController {
        return DetailsRoutineViewController(scheduler: NotificationScheduler(center: center))
    }

    class SpyNotificationCenter: NotificationCenterProtocol {
        var addCalled = false

        func add(_: UNNotificationRequest, withCompletionHandler _: ((Error?) -> Swift.Void)?) {
            addCalled = true
        }
    }
}
