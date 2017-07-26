import Foundation

struct FavoritesViewModel {

    let quotesToDisplay: [Quote]

    init(state: AppState, initialQuoteIds: [Int]) {
        self.quotesToDisplay = state.quotes.reduce([]) { (result, quote) in
            return result + (initialQuoteIds.contains(quote.id) ? [quote] : [])
        }
    }

    static func getFavoriteQuoteIds(quotes: [Quote]) -> [Int] {
        return quotes
                .filter({ $0.isFavorite })
                .map { $0.id }
    }
}
