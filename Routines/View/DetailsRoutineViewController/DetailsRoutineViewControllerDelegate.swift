import Foundation

protocol DetailsRoutineViewControllerDelegate: class {
    func routeToRepeatViewController() -> Void
    func changeStatusDoneButton(status: Bool) -> Void
}
