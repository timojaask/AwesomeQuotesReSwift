import ReSwift

class TestStore: DispatchingStoreType {
    var dispatchedAction = FetchQuotes(.none)
    func dispatch(_ action: Action) {
        dispatchedAction = action as! FetchQuotes
    }
}
