@testable import Routines
import XCTest

class RoutineTest: XCTestCase {
    func test_canCreateRoutine() {
        let today = Date()
        let sut = makeSUT(name: "FirstRoutine", alarm: true, date: today)

        XCTAssertNotNil(sut)
    }

    // MARK: Helpers

    func makeSUT(name: String, alarm: Bool, date: Date) -> Routine {
        return Routine(name: name, alarm: alarm, date: date)
    }
}
