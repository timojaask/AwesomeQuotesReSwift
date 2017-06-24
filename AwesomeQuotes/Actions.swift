import ReSwift

struct NextQuote: Action {}
struct SetQuotes: Action {
    let quotes: [Quote]
}
struct SetFetchingQuotes: Action {
    let fetching: Bool
}
struct ToggleFavoriteForCurrentQuote: Action { }

func fetchQuotes(state: AppState, store: MainStore) -> Action? {
    let debugQuotes = (1...10).map { index -> Quote in
        return Quote(text: "Quote \(index)", author: "Author \(index)")
    }
    let when = DispatchTime.now() + 2
    DispatchQueue.main.asyncAfter(deadline: when) {
        store.dispatch(SetFetchingQuotes(fetching: false))
        store.dispatch(SetQuotes(quotes: debugQuotes))
    }
    return SetFetchingQuotes(fetching: true)

}
