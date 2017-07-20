import Quick
import Nimble
@testable import AwesomeQuotes

class ActionsSpec: QuickSpec {
    override func spec() {
        describe("FetchQuotes") {

            it("initializer correctly initializes the state property") {
                let state = FetchQuotesState.request
                let action = FetchQuotes(state)

                expect(action.state).to(equal(state))
            }
        }
    }
}
