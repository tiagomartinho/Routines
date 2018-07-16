import XCTest
import UserNotifications

@testable import Routines

class NotifcationSchedulerTest: XCTestCase {
    
    func test_ensureSchedulerAddsRequestToCenter() {
        let center = SpyNotifcationCenter()
        let scheduler = NotificationScheduler(center: center)
        
        scheduler.schedule()
        
        XCTAssert(center.addCalled)
    }
    
    class SpyNotifcationCenter: NotifcationCenter {
        
        var addCalled = false
        
        func add(_ request: UNNotificationRequest, withCompletionHandler completionHandler: ((Error?) -> Swift.Void)?) {
            addCalled = true
        }
    }
}
