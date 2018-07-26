@testable import Routines
import XCTest

class DateHelperTest: XCTestCase {
    func test_WhenSendDate_ReceiveInCorrectFormat() {
        let date = Date(timeIntervalSince1970: 10)

        let result = DateHelper.convertDateToString(date: date)
        XCTAssertEqual("1970-01-01 01:00", result)
    }
}
