protocol RoutineRepository: class {
    func save(_ routine: Routine)
    func getAll() -> [Routine]
}
