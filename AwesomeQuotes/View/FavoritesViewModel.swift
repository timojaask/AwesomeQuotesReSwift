import Foundation

struct FavoritesViewModel {

    let state: AppState
    let quotesToDisplay: [Quote]

    init(state: AppState, initialQuotes: [Quote]) {
        self.state = state

        let initialQuotesSet = Set(initialQuotes)
        let currentQuotesSet = Set(state.quotes)
        let quotesToDisplaySet = currentQuotesSet.intersection(initialQuotesSet)
        self.quotesToDisplay = Array(quotesToDisplaySet)
    }
}
