import XCTest
import UserNotifications

@testable import Routines

class NotifcationSchedulerTest: XCTestCase {
    
    func test_ensureSchedulerAddsRequestToCenter() {
        let center = SpyNotificationCenter()
        let sut = makeSUT(center)
        XCTAssertFalse(center.addCalled)

        sut.schedule()
        
        XCTAssert(center.addCalled)
    }
    
    //MARK: Helpers
    
    func makeSUT(_ center: NotificationCenterProtocol) -> NotificationScheduler {
        return NotificationScheduler(center: center)
    }
    
     class SpyNotificationCenter: NotificationCenterProtocol {
        
        var addCalled = false
        
        func add(_ request: UNNotificationRequest, withCompletionHandler completionHandler: ((Error?) -> Swift.Void)?) {
            addCalled = true
        }
    }
}

