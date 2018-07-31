import Foundation

class Routine {
    private var id: String?
    private var name: String?
    private var alarm: Bool?
    private var date: Date?
    private var frequency: Frequency?

    init(name: String, alarm: Bool, date: Date, frequency: Frequency? = nil) {
        self.name = name
        self.alarm = alarm
        self.date = date
        self.frequency = frequency
        id = UUID().uuidString
    }

    func getId() -> String {
        return id != nil ? id! : ""
    }
}
