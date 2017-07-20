import Foundation
@testable import AwesomeQuotes

let notFavoriteQuoteIndexInDefaultSet: Int = 0
let favoriteQuoteIndexInDefaultSet: Int = 1

func randomQuote(isFavorite: Bool = false) -> Quote {
    return Quote(
        text: String.random(length: 20),
        author: String.random(length: 20),
        isFavorite: isFavorite)
}

func remoteSetOfQuotes(number: Int = 4) -> [Quote] {
    return (0..<number).map { _ in randomQuote() }
}

func defaultSetOfQuotes() -> [Quote] {
    return [
        randomQuote(),
        randomQuote(isFavorite: true)
    ]
}

func anotherSetOfQuotes() -> [Quote] {
    return [
        randomQuote(),
        randomQuote(),
        randomQuote(isFavorite: true)
    ]
}

func stateWithNoQuotes() -> AppState {
    return AppState()
}

func stateWithQuotes(selectFavoriteQuote: Bool = false) -> AppState {
    let quotes = defaultSetOfQuotes()
    let currentQuoteIndex = selectFavoriteQuote ? favoriteQuoteIndexInDefaultSet : notFavoriteQuoteIndexInDefaultSet;
    let currentQuote = quotes[currentQuoteIndex]

    return AppState(
        quotes: quotes,
        currentQuoteIndex: currentQuoteIndex,
        currentQuote: currentQuote,
        fetchQuotesState: .none)
}

func viewModelWithNoQuotes() -> RootViewModel {
    return RootViewModel(state: stateWithNoQuotes())
}

func viewModelWithQuotes(selectFavoriteQuote: Bool = false) -> RootViewModel {
    return RootViewModel(state: stateWithQuotes(selectFavoriteQuote: selectFavoriteQuote))
}
