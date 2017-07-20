import Foundation

struct RootViewModel {

    let state: AppState

    var currentQuote: Quote? {
        guard state.quotes.count > state.currentQuoteIndex,
            state.currentQuoteIndex >= 0 else {
            return nil
        }
        return state.quotes[state.currentQuoteIndex]
    }

    var quoteText: String {
        guard let quote = self.currentQuote else {
            return "No quotes to display"
        }
        return quote.text
    }

    var quoteAuthor: String {
        guard let quote = self.currentQuote else {
            return ""
        }
        return " – \(quote.author)"
    }

    var nextQuoteButtonHidden: Bool {
        return state.quotes.count == 0
    }

    var favoriteButtonHidden: Bool {
        return self.currentQuote == nil
    }

    var favoriteButtonTitle: String {
        guard let isFavorite = self.currentQuote?.isFavorite else {
            return ""
        }
        return isFavorite ? "Remove from favs" : "Add to favs"
    }

    var isFavoriteLabelText: String {
        guard let isFavorite = self.currentQuote?.isFavorite else {
            return ""
        }
        return isFavorite ? "IS FAVORITE" : "not favorite"
    }
}
