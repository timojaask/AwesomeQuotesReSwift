import PromiseKit
import ReSwift

protocol LocalStorage {
    func saveState(state: AppState) -> Promise<Void>
    static func loadState() -> Promise<AppState>
}

// TODO: Unit tests
class StatePersister: StoreSubscriber {
    let localStorage: LocalStorage
    let store: DispatchingStoreType

    init(localStorage: LocalStorage, store: DispatchingStoreType) {
        self.localStorage = localStorage
        self.store = store
    }

    func newState(state: AppState) {
        localStorage.saveState(state: state)
            .then { () -> Void in }
            .catch { error in print("Failed to persist store. Error: \(error.localizedDescription)") }
    }
}
