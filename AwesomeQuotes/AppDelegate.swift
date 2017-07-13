import UIKit
import ReSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var store: MainStore!
    var asyncRequestHandler: AsyncRequestHandler?
    var statePersister: StatePersister?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        loadPersistedAppState()

        return true
    }

    func loadPersistedAppState() {
        FileStorage.loadState()
            .then(execute: initStore)
            .catch(execute: handleLoadStateError)
    }

    func handleLoadStateError(error: Error) {
        print("ERROR: Failed to load persisted app state")
        initStore()
    }

    func initStore(appState: AppState = AppState()) {
        self.store = MainStore(reducer: appReducer, state: appState)
        let quotesService = RemoteQuotesService(networkService: AppNetworkService())
        self.statePersister = StatePersister(localStorage: FileStorage())
        self.asyncRequestHandler = AsyncRequestHandler(quotesService: quotesService, store: store)
        store.subscribe(self.asyncRequestHandler!)
        store.subscribe(self.statePersister!)
        store.dispatch(FetchQuotes(.request))

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController(store: store)
        window?.makeKeyAndVisible()
    }

}
