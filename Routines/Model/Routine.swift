import Foundation

class Routine {
    private var id: String?
    private var name: String?
    private var alarm: Bool?
    private var date: Date?

    init(name: String, alarm: Bool, date: Date) {
        self.name = name
        self.alarm = alarm
        self.date = date
        id = UUID().uuidString
    }
}
