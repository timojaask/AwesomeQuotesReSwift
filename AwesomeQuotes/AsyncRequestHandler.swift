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
        if case .request = state.fetchQuotesState {
            quotesService.getQuotes()
                .then { self.store.dispatch(FetchQuotes(.success(quotes: $0))) }
                .catch { self.store.dispatch(FetchQuotes(.error(error: $0))) }
        }
    }
}
