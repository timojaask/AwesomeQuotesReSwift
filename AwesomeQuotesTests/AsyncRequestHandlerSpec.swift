import Quick
import Nimble
import ReSwift
import PromiseKit

class AsyncRequestHandlerSpec: QuickSpec {
    override func spec() {
        describe("Next state handler") {

            it("dispatches success action with correct data after successful request") {
                let testData = defaultSetOfQuotes()
                let testStore = TestStore()
                requestData(store: testStore, quotes: testData)

                let expectedAction = FetchQuotes(.success(quotes: testData))
                expect(testStore.dispatchedAction).toEventually(equal(expectedAction), timeout: 1)
            }

            it("dispatches error action with correct error after failed request") {
                let testError = TestError.someError
                let testStore = TestStore()
                requestData(store: testStore, quotes: [], failing: true, error: testError)

                let expectedAction = FetchQuotes(.error(error: testError))
                expect(testStore.dispatchedAction).toEventually(equal(expectedAction), timeout: 1)
            }
        }
    }
}

func requestData(store: DispatchingStoreType, quotes: [Quote], failing: Bool = false, error: Error = TestError.someError) {
    let testDataService = TestQuotesService(quotes: quotes, failing: failing, error: error)
    let asyncRequestHandler = AsyncRequestHandler(quotesService: testDataService, store: store)

    let newState = AppState(quotes: [], currentQuoteIndex: -1, currentQuote: nil, fetchQuotesState: .request)
    asyncRequestHandler.newState(state: newState)
}

struct TestQuotesService: QuotesService {
    let quotes: [Quote]
    let failing: Bool
    let error: Error

    func getQuotes() -> Promise<[Quote]> {
        if failing {
            return Promise.init(error: error)
        }
        return Promise.init(value: quotes)
    }
}
