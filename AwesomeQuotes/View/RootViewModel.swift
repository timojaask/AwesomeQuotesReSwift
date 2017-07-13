import Foundation

struct RootViewModel {

    let state: AppState

    var quoteText: String {
        guard let quote = state.currentQuote else {
            return "No quotes to display"
        }
        return quote.text
    }

    var quoteAuthor: String {
        guard let quote = state.currentQuote else {
            return ""
        }
        return " – \(quote.author)"
    }

    var nextQuoteButtonHidden: Bool {
        return state.quotes.count == 0
    }

    var favoriteButtonHidden: Bool {
        return state.currentQuote == nil
    }

    var favoriteButtonTitle: String {
        guard let isFavorite = state.currentQuote?.isFavorite else {
            return ""
        }
        return isFavorite ? "Remove from favs" : "Add to favs"
    }

    var isFavoriteLabelText: String {
        guard let isFavorite = state.currentQuote?.isFavorite else {
            return ""
        }
        return isFavorite ? "IS FAVORITE" : "not favorite"
    }
}
