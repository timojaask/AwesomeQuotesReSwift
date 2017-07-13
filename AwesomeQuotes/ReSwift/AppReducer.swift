import ReSwift

func appReducer (action: Action, state: AppState?) -> AppState {
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

    case let action as FetchQuotes:
        state.fetchQuotesState = action.state
        if case let .success(quotes) = action.state {
            state.quotes = mergeFetchedQuotes(remoteQuotes: quotes, localQuotes: state.quotes)
            if state.currentQuoteIndex < 0 && state.quotes.count > 0 {
                state.currentQuoteIndex = 0
                state.currentQuote = state.quotes[state.currentQuoteIndex]
            }
        }

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

func mergeFetchedQuotes(remoteQuotes: [Quote], localQuotes: [Quote]) -> [Quote] {
    let localFavorites = localQuotes.filter { $0.isFavorite }
    return remoteQuotesWithFavoriteFlagsMerged(remoteQuotes: remoteQuotes, localFavorites: localFavorites) +
        localQuotesToAdd(remoteQuotes: remoteQuotes, localFavorites: localFavorites)
}

func localQuotesToAdd(remoteQuotes: [Quote], localFavorites: [Quote]) -> [Quote] {
    return localFavorites.reduce([]) { (soFar, localFavoriteQuote) -> [Quote] in
        return remoteQuotes.contains(where: { $0.text == localFavoriteQuote.text }) ?
            soFar : soFar + [localFavoriteQuote]
    }
}

func remoteQuotesWithFavoriteFlagsMerged(remoteQuotes: [Quote], localFavorites: [Quote]) -> [Quote] {
    return remoteQuotes.map { remoteQuote -> Quote in
        let localQuote = localFavorites.filter({ $0.text == remoteQuote.text }).first
        return localQuote ?? remoteQuote
    }
}