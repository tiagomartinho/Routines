import Foundation

class Routine {

    let id = UUID().uuidString
    private let name: String
    private let alarm: Bool
    private let date: Date
    private let frequency: Frequency

    init(name: String, alarm: Bool, date: Date, frequency: Frequency) {
        self.name = name
        self.alarm = alarm
        self.date = date
        self.frequency = frequency
    }
}
