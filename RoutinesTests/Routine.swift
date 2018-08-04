@testable import Routines
import XCTest

class RoutineTest: XCTestCase {
    func test_whenCreateRoutine_canCreateRoutine() {
        let today = Date()
        let sut = makeSUT(name: "FirstRoutine", alarm: true, date: today)

        XCTAssertNotNil(sut)
    }

    func test_whenCreateRoutine_canGetId() {
        let today = Date()
        let sut = makeSUT(name: "FirstRoutine", alarm: true, date: today)

        XCTAssertNotNil(sut.id)
    }

    // MARK: Helpers

    func makeSUT(name: String, alarm: Bool, date: Date) -> Routine {
        return Routine(name: name, alarm: alarm, date: date, frequency: .never)
    }
}
