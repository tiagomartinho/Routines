import Foundation

enum Frequency: String {
    case never = "Never"
    case day = "Every Day"
    case week = "Every Week"
    case month = "Every Month"
    case year = "Every Year"

    static let allValues = [never, day, week, month, year]
}
