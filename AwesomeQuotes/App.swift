import UIKit
import ReSwift
import PromiseKit

let localStorageAppStateFileName = "AwesomeQuotes-appState"

struct App {
    // StatePersister must have a strong reference, because we don't want it to be deallocated.
    let statePersister: StatePersister

    init(window: UIWindow) {
        let quotesService = RemoteQuotesService(networkService: AppNetworkService())
        let fileStorage = FileStorage(fileName: localStorageAppStateFileName)
        let statePersister = StatePersister(localStorage: fileStorage)
        self.statePersister = statePersister

        loadAppState(fileStorage: fileStorage)
            .then { appState in initStore(appState: appState, quotesService: quotesService) }
            .then { store in initStoreSubscriptions(store: store, statePersister: statePersister) }
            .then { store in dispatchFetchQuotesAction(store: store) }
            .then { store in initRootViewController(store: store) }
            .then { vc in displayViewController(rootViewController: vc, window: window) }
            .catch { error in handleInitError(error: error) }
    }
}

func loadAppState(fileStorage: LocalStorage) -> Promise<AppState> {
    return fileStorage.loadState()
        .recover { _ in return AppState() }
}

func initStore(appState: AppState, quotesService: RemoteQuotesService) -> MainStore {
    let sideEffects = injectService(service: quotesService, receivers: quotesServiceSideEffects)
    let middleware = createMiddleware(items: sideEffects)
    return Store<AppState>(reducer: appReducer, state: appState, middleware: [middleware])
}

func initStoreSubscriptions(store: MainStore, statePersister: StatePersister) -> MainStore {
    store.subscribe(statePersister)
    return store
}

func dispatchFetchQuotesAction(store: MainStore) -> MainStore {
    store.dispatch(FetchQuotes.request)
    return store
}

func initRootViewController(store: MainStore) -> RootViewController {
    return RootViewController(store: store)
}

func displayViewController(rootViewController: RootViewController, window: UIWindow) {
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
}

func handleInitError(error: Error) {
    print("init failed")
}
