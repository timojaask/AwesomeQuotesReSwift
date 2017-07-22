import Foundation

struct FavoritesCellViewModel {

    let quote: Quote

    var quoteText: String {
        return quote.text
    }

    var quoteAuthor: String {
        return " – \(quote.author)"
    }
}
