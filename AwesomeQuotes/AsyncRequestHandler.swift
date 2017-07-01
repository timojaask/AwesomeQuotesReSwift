import Foundation
import ReSwift

class AsyncRequestHandler: StoreSubscriber {
    let quotesService: QuotesService
    let store: DispatchingStoreType

    init(quotesService: QuotesService, store: DispatchingStoreType) {
        self.quotesService = quotesService
        self.store = store
    }

    func newState(state: AppState) {
        if case FetchQuotesState.request = state.fetchQuotesState {
            quotesService.getQuotes()
                .then { quotes -> () in
                    self.store.dispatch(FetchQuotes(.success(quotes: quotes)))
                }
                .catch { error in
                    self.store.dispatch(FetchQuotes(.error(error: error)))
            }
        }
    }
}
