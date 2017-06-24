import ReSwift

struct AppState: StateType {
    var quotes: [Quote] = []
    var currentQuoteIndex: Int = -1
    var currentQuote: Quote?
    var fetchingQuotes: Bool = false
}
