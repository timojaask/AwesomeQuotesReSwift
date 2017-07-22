import Foundation

struct FavoritesViewModel {

    let state: AppState

    var favoriteQuotes: [Quote] {
        return state.quotes.filter { $0.isFavorite }
    }
}
