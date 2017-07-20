import UIKit
import ReSwift

let localStorageAppStateFileName = "AwesomeQuotes-appState"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var store: MainStore!
    var statePersister: StatePersister?
    let fileStorage = FileStorage(fileName: localStorageAppStateFileName)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        loadPersistedAppState()

        return true
    }

    func loadPersistedAppState() {
        fileStorage.loadState()
            .then(execute: initStore)
            .catch(execute: handleLoadStateError)
    }

    func handleLoadStateError(error: Error) {
        print("ERROR: Failed to load persisted app state")
        initStore()
    }

    func initStore(appState: AppState = AppState()) {
        let quotesService = RemoteQuotesService(networkService: AppNetworkService())
        let sideEffects = injectService(service: quotesService, receivers: dataServiceSideEffects)
        let middleware = createMiddleware(items: sideEffects)
        store = Store<AppState>(reducer: appReducer, state: appState, middleware: [middleware])
        self.statePersister = StatePersister(localStorage: fileStorage)
        store.subscribe(self.statePersister!)
        store.dispatch(FetchQuotes.request)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController(store: store)
        window?.makeKeyAndVisible()
    }

}
