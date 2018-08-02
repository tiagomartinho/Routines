class InMemoryRepository: RoutineRepository {
    private var routines = [Routine]()

    func save(_ routine: Routine) {
        routines.append(routine)
    }

    func getAll() -> [Routine] {
        return routines
    }
}
