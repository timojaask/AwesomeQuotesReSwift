import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    switch action {
    case _ as NextQuote:
        guard state.quotes.count > 0 else {
            break
        }
        state.currentQuoteIndex += 1
        if state.currentQuoteIndex >= state.quotes.count {
            state.currentQuoteIndex = 0
        }
        state.currentQuote = state.quotes[state.currentQuoteIndex]

    case let action as SetQuotes:
        state.quotes = action.quotes
        if state.currentQuoteIndex < 0 && state.quotes.count > 0 {
            state.currentQuoteIndex = 0
            state.currentQuote = state.quotes[state.currentQuoteIndex]
        }
    case let action as SetFetchingQuotes:
        state.fetchingQuotes = action.fetching
    case _ as ToggleFavoriteForCurrentQuote:
        guard state.quotes.count > 0 else {
            break
        }
        state.quotes[state.currentQuoteIndex].isFavorite = !state.quotes[state.currentQuoteIndex].isFavorite
        state.currentQuote = state.quotes[state.currentQuoteIndex]
    default:
        break
    }
    return state
}
