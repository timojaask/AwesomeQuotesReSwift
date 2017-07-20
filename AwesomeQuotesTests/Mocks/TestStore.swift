import ReSwift
@testable import AwesomeQuotes

class TestStore: DispatchingStoreType {
    var dispatchedAction: Action?
    func dispatch(_ action: Action) {
        dispatchedAction = action
    }
}
