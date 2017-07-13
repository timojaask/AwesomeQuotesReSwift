import Quick
import Nimble
import ReSwift
import PromiseKit

class StorePersisterSpec: QuickSpec {
    override func spec() {
        describe("Next state handler") {

            it("passes AppState to LocalStorage.saveState when state is updated") {
                let testState = stateWithQuotes()
                let testLocalStorage = TestLocalStorage()
                let statePersister = StatePersister(localStorage: testLocalStorage)

                statePersister.newState(state: testState)

                expect(testLocalStorage.savedState).toEventually(equal(testState))
            }
        }
    }
}

class TestLocalStorage: LocalStorage {
    var savedState: AppState?

    func saveState(state: AppState) -> Promise<Void> {
        self.savedState = state
        return Promise.init { (fulfill, _) in fulfill() }
    }

    func loadState() -> Promise<AppState> {
        fatalError("Not implemented")
    }
}
