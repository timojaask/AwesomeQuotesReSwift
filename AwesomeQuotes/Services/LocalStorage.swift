import PromiseKit

protocol LocalStorage {
    func saveState(state: AppState) -> Promise<Void>
    static func loadState() -> Promise<AppState>
}
