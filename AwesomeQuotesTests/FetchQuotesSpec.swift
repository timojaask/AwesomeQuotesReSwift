import Quick
import Nimble
import ReSwift
@testable import AwesomeQuotes

class FetchQuotesSpec: QuickSpec {

    override func spec() {
        describe("fetchQuotes") {

            it("Does not call fetchQuotes service when action is not FetchQuotes") {
                struct testAction: Action { }
                let testQuotesService = TestQuotesService(fetchQuotesCallback: {
                    fail("The test was not supposed to call fetchQuotes QuotesService method")
                })
                let middlewareItem = fetchQuotes(quotesService: testQuotesService)
                middlewareItem(testAction()) { _ in }
            }

            it("Does not call fetchQuotes service when action is FetchQuotes and type is not request") {
                let testQuotesService = TestQuotesService(fetchQuotesCallback: {
                    fail("The test was not supposed to call fetchQuotes QuotesService method")
                })
                let middlewareItem = fetchQuotes(quotesService: testQuotesService)
                middlewareItem(FetchQuotes.success(quotes: [])) { _ in }
            }

            it("Dispatches FetchQuotes.success action with correct users after FetchQuotes.request is passed") {
                let expected = remoteSetOfQuotes()
                let testQuotesService = TestQuotesService(quotes: expected)
                let middlewareItem = fetchQuotes(quotesService: testQuotesService)

                var actual: [Quote] = []
                middlewareItem(FetchQuotes.request) { action in
                    guard let action = action as? FetchQuotes,
                        case .success(let fetchedQuotes) = action else {
                            fail("Expected middleware to dispatch FetchQuotes.success action")
                            return
                    }
                    actual = fetchedQuotes
                }
                expect(actual).toEventually(equal(expected), timeout: 1)
            }

            it("Dispatches FetchQuotes.error action if error occurs") {
                let testQuotesService = TestQuotesService(shouldFail: true)
                let middlewareItem = fetchQuotes(quotesService: testQuotesService)

                let expected = TestQuotesServiceError.someError
                var actual: Error?
                middlewareItem(FetchQuotes.request) { action in
                    guard let action = action as? FetchQuotes,
                        case .failure(let error) = action else {
                            fail("Expected middleware to dispatch FetchQuotes.failure action")
                            return
                    }
                    actual = error
                }
                expect(actual).toEventually(matchError(expected), timeout: 1)
            }
        }
    }
}
