@testable import Routines
import UserNotifications
import XCTest

class AddRoutineViewTest: XCTestCase {
    func test_tableViewLoad_renderActivateNotificationCell() {
        let addRoutineDelegate = SpyAddRoutineDelegate()

        let sut = makeSUT(addRoutineDelegate)
        let cell = sut.settingsTableView.cell(at: 0) as? ActivateNotificationCell

        XCTAssertNotNil(cell)
    }

    func test_tableViewLoad_renderDatePickerCell() {
        let addRoutineDelegate = SpyAddRoutineDelegate()

        let sut = makeSUT(addRoutineDelegate)
        let cell = sut.settingsTableView.cell(at: 1) as? DatePickerCell

        XCTAssertNotNil(cell)
    }

    func test_tableViewCell_WhenValueChange_SwitchCallDelegate() {
        let addRoutineDelegate = SpyAddRoutineDelegate()
        let sut = makeSUT(addRoutineDelegate)
        let cell = sut.settingsTableView.cell(at: 0) as? ActivateNotificationCell

        cell?.notificationSwitch.sendActions(for: .valueChanged)

        XCTAssert(addRoutineDelegate.fired)
    }

    // MARK: Helpers

    func makeSUT(_ delegate: AddRoutineViewDelegate) -> AddRoutineView {
        let sut = AddRoutineView(delegate: delegate)
        return sut
    }

    class SpyAddRoutineDelegate: AddRoutineViewDelegate {
        var fired = false

        func routineOn() {
            fired = true
        }

        func routineOff() {
            fired = true
        }
    }
}

extension UITableView {
    func cell(at row: Int) -> UITableViewCell {
        let indexPath = IndexPath(row: row, section: 0)
        return (dataSource?.tableView(self, cellForRowAt: indexPath))!
    }
}
