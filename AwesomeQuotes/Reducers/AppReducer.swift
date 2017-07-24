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

    case let action as FetchQuotes:
        if case .success(let quotes) = action {
            state.quotes = mergeFetchedQuotes(remoteQuotes: quotes, localQuotes: state.quotes)
            if state.currentQuoteIndex < 0 && state.quotes.count > 0 {
                state.currentQuoteIndex = 0
            }
        }

    case let action as ToggleFavorite:
        guard let quoteIndex = state.quotes.index(where: { $0 == action.quote }) else {
            break
        }
        state.quotes[quoteIndex].isFavorite = !state.quotes[quoteIndex].isFavorite

    case _ as ToggleFavoriteForCurrentQuote:
        guard state.quotes.count > 0 else {
            break
        }
        state.quotes[state.currentQuoteIndex].isFavorite = !state.quotes[state.currentQuoteIndex].isFavorite

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
