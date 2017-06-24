import Foundation

extension AppState: Equatable { }
func ==(lhs: AppState, rhs: AppState) -> Bool {
    return
        lhs.currentQuoteIndex == rhs.currentQuoteIndex &&
            lhs.currentQuote == rhs.currentQuote &&
            lhs.fetchingQuotes == rhs.fetchingQuotes &&
            lhs.quotes == rhs.quotes

}

extension Quote: Equatable { }
func ==(lhs: Quote, rhs: Quote) -> Bool {
    return
        lhs.author == rhs.author &&
            lhs.isFavorite == rhs.isFavorite &&
            lhs.text == rhs.text
}
