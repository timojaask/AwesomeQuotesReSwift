import Foundation

struct FavoritesViewModel {

    let quotesToDisplay: [Quote]

    init(state: AppState, initialQuoteIds: [Int]) {
        self.quotesToDisplay = state.quotes.reduce([]) { (result, quote) in
            return result + (initialQuoteIds.contains(quote.id) ? [quote] : [])
        }
    }

    static func initialQuoteIds(initialQuotes: [Quote]) -> [Int] {
        return initialQuotes
                .filter({ $0.isFavorite })
                .map { $0.id }
    }
}
