import UIKit
import Cartography
import ReSwift

class FavoritesViewController: BaseViewController {

    var favoritesView: FavoritesView!

    // initialQuoteIds is a an array of quote IDs that are marked as "isFavorite" at the time
    // when this view controller is instantiated. These quotes will be displayed 
    // on this screen and user will be able to un-favorite and favorite them.
    let initialQuoteIds: [Int]

    override init(store: MainStore) {
        self.initialQuoteIds = FavoritesViewModel.getFavoriteQuoteIds(quotes: store.state.quotes)
        super.init(store: store)

        favoritesView = FavoritesView(
            closeHandler: { [weak self] in self?.close() },
            toggleFavorite: { [weak self] (quoteId: Int) in
                self?.toggleFavorite(quoteId: quoteId)
            }
        )
        self.view = favoritesView
    }

    func close() {
        dismiss(animated: true, completion: nil)
    }

    func toggleFavorite(quoteId: Int) {
        store.dispatch(ToggleFavorite(quoteId: quoteId))
    }

    override func newState(state: AppState) {
        favoritesView.updateView(viewModel: FavoritesViewModel(state: state, initialQuoteIds: initialQuoteIds))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
