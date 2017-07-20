import ReSwift

struct NextQuote: Action {}

struct ToggleFavoriteForCurrentQuote: Action { }

enum FetchQuotes: Action {
    case request
    case success(quotes: [Quote])
    case failure(error: Error)
}
