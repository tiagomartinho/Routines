import Foundation

struct Routine {
    let id = UUID().uuidString
    let name: String
    let alarm: Bool
    let date: Date
    let frequency: Frequency
}
