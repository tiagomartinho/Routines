@testable import Routines
import UserNotifications
import XCTest

class NotifcationSchedulerTest: XCTestCase {
    func test_ensureSchedulerAddsRequestToCenter() {
        let center = SpyNotifcationCenter()
        let scheduler = NotificationScheduler(center: center)

        scheduler.schedule()

        XCTAssert(center.addCalled)
    }

    class SpyNotifcationCenter: NotificationCenterProtocol {
        var addCalled = false

        func add(_: UNNotificationRequest, withCompletionHandler _: ((Error?) -> Swift.Void)?) {
            addCalled = true
        }
    }
}
