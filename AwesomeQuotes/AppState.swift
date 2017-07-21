import ReSwift

struct AppState: StateType {
    var quotes: [Quote] = []
    var currentQuoteIndex: Int = -1
}
