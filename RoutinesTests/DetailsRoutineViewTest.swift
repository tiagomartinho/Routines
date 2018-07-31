@testable import Routines
import UserNotifications
import XCTest

class DetailsRoutineViewTest: XCTestCase {
    func test_tableViewLoad_renderActivateNotificationCell() {
        let sut = makeSUT()

        XCTAssertNotNil(sut.settingsTableView)
    }

    // MARK: Helpers

    func makeSUT() -> DetailsRoutineView {
        let sut = DetailsRoutineView()
        return sut
    }
}

extension UITableView {
    func cell(at row: Int) -> UITableViewCell {
        let indexPath = IndexPath(row: row, section: 0)
        return (dataSource?.tableView(self, cellForRowAt: indexPath))!
    }
}
