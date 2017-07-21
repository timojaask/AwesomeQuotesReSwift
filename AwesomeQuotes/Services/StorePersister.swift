import ReSwift

class StatePersister: StoreSubscriber {
    let localStorage: LocalStorage

    init(localStorage: LocalStorage) {
        self.localStorage = localStorage
    }

    func newState(state: AppState) {
        localStorage.saveState(state: state)
            .then { () -> Void in }
            .catch { error in print("Failed to persist store. Error: \(error.localizedDescription)") }
    }
}
