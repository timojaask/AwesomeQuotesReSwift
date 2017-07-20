import ReSwift

func fetchQuotes(quotesService: QuotesService) -> MiddlewareItem {
    return { (action: Action, dispatch: @escaping DispatchFunction) in
        guard let action = action as? FetchQuotes,
            case .request = action else { return }

        quotesService.fetchQuotes()
            .then { dispatch(FetchQuotes.success(quotes: $0)) }
            .catch { dispatch(FetchQuotes.failure(error: $0)) }
    }
}
