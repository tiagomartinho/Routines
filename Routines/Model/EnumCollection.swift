// From Swift 4.2 you can simply conform to the CaseIterable protocol, and you'll get the allCases static property for free

protocol EnumCollection: Hashable {
    static var allValues: [Self] { get }
}

extension EnumCollection {

    static func cases() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }

    static var allValues: [Self] {
        return Array(cases())
    }
}
