import UIKit
import ReSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let store = MainStore(reducer: appReducer, state: nil)
    var asyncRequestHandler: AsyncRequestHandler?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController(store: store)
        window?.makeKeyAndVisible()
        asyncRequestHandler = AsyncRequestHandler(quotesService: RemoteQuotesService(), store: store)
        store.subscribe(asyncRequestHandler!)
        store.dispatch(FetchQuotes(.request))
        return true
    }

}
