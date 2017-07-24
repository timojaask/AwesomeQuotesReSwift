import UIKit

struct FavoritesCellViewModel {

    let quote: Quote

    var quoteText: String {
        return quote.text
    }

    var quoteAuthor: String {
        return " – \(quote.author)"
    }

    var favoriteButtonImage: UIImage {
        return quote.isFavorite ?
            R.image.favorite_on()! :
            R.image.favorite_off()!
    }
}
