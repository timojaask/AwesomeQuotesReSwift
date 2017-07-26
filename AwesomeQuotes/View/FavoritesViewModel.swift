import Foundation

struct FavoritesViewModel {

    let state: AppState
    let quotesToDisplay: [Quote]

    init(state: AppState, initialQuoteIds: [Int]) {
        self.state = state
        self.quotesToDisplay = state.quotes.reduce([]) { (result, quote) in
            return result + (initialQuoteIds.contains(quote.id) ? [quote] : [])
        }
    }
}
