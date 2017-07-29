import UIKit
import ReSwift
import PromiseKit

struct App {
    static let localStorageAppStateFileName = "AwesomeQuotes-appState"

    let statePersister: StatePersister
    let window: UIWindow

    init(window: UIWindow) {
        let fileStorage = FileStorage(fileName: App.localStorageAppStateFileName)
        self.window = window
        self.statePersister = StatePersister(localStorage: fileStorage)

        loadAppState(fileStorage: fileStorage)
            .then(execute: self.initStore)
            .then(execute: initStoreSubscriptions)
            .then(execute: dispatchFetchQuotesAction)
            .then(execute: initRootViewController)
            .then(execute: displayViewController)
            .catch(execute: handleInitError)
    }

    func loadAppState(fileStorage: FileStorage) -> Promise<AppState> {
        return fileStorage.loadState()
            .recover { _ in return AppState() }
    }

    func initStore(appState: AppState) -> MainStore {
        let quotesService = RemoteQuotesService(networkService: AppNetworkService())
        let sideEffects = injectService(service: quotesService, receivers: quotesServiceSideEffects)
        let middleware = createMiddleware(items: sideEffects)
        return Store<AppState>(reducer: appReducer, state: appState, middleware: [middleware])
    }

    func initStoreSubscriptions(store: MainStore) -> MainStore {
        store.subscribe(self.statePersister)
        return store
    }

    func dispatchFetchQuotesAction(store: MainStore) -> MainStore {
        store.dispatch(FetchQuotes.request)
        return store
    }

    func initRootViewController(store: MainStore) -> RootViewController {
        return RootViewController(store: store)
    }

    func displayViewController(rootViewController: RootViewController) {
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }

    func handleInitError(error: Error) {
        print("init failed")
    }
}
