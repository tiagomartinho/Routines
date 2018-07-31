@testable import Routines
import UserNotifications
import XCTest

class NotifcationSchedulerTest: XCTestCase {
    func test_ensureSchedulerAddsRequestToCenter() {
        let center = SpyNotificationCenter()
        let sut = makeSUT(center)
        XCTAssertFalse(center.addCalled)

        sut.createNotificationOnDate(id: "teste", name: "teste", date: Date(), frequency: Frequency.day)

        XCTAssert(center.addCalled)
    }

    // MARK: Helpers

    func makeSUT(_ center: NotificationCenterProtocol) -> NotificationScheduler {
        return NotificationScheduler(center: center)
    }

    class SpyNotificationCenter: NotificationCenterProtocol {
        var addCalled = false

        func add(_: UNNotificationRequest, withCompletionHandler _: ((Error?) -> Swift.Void)?) {
            addCalled = true
        }
    }
}
