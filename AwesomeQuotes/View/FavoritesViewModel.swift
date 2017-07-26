import Foundation

struct FavoritesViewModel {

    let state: AppState
    let quotesToDisplay: [Quote]

    init(state: AppState, initialQuotes: [Quote]) {
        self.state = state
        self.quotesToDisplay = state.quotes.reduce([]) { (result, quote) in
            return result + (initialQuotes.contains(quote) ? [quote] : [])
        }
    }
}
