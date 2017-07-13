import PromiseKit

protocol LocalStorage {
    func saveState(state: AppState) -> Promise<Void>
    func loadState() -> Promise<AppState>
}
