import ReSwift

struct NextQuote: Action {}

struct ToggleFavoriteForCurrentQuote: Action { }

struct FetchQuotes: Action {
    let state: FetchQuotesState
    init(_ state: FetchQuotesState) { self.state = state }
}

enum FetchQuotesState {
    case none
    case request
    case success(quotes: [Quote])
    case error(error: Error)
}