import UIKit
import Cartography
import ReSwift

class FavoritesViewController: BaseViewController {

    var favoritesView: FavoritesView!

    // initialQuotes is a an array of quotes that are marked as "isFavorite" at the time
    // when this view controller is instantiated. These quotes will be displayed 
    // on this screen and user will be able to un-favorite them. However, we don't want
    // the quote to disappear as soon as it's un-favorited, to allow user to undo the
    // action. So this list acts as a view local cache of all the items it is displaying.
    let initialQuoteIds: [Int]

    override init(store: MainStore) {
        self.initialQuoteIds = store.state.quotes.filter({ $0.isFavorite }).map { $0.id }
        super.init(store: store)

        favoritesView = FavoritesView(
            closeHandler: { [weak self] in self?.close() },
            toggleFavorite: { [weak self] (quote: Quote) in
                self?.toggleFavorite(quote: quote)
            }
        )
        self.view = favoritesView
    }

    func close() {
        dismiss(animated: true, completion: nil)
    }

    func toggleFavorite(quote: Quote) {
        store.dispatch(ToggleFavorite(quote: quote))
    }

    override func newState(state: AppState) {
        favoritesView.updateView(viewModel: FavoritesViewModel(state: state, initialQuoteIds: initialQuoteIds))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
