import Foundation

class DateHelper {
    static func convertDateToString(date: Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatterGet.string(from: date)
    }
}
