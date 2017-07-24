import UIKit
import Cartography
import ReSwift

class FavoritesViewController: BaseViewController {

    var favoritesView: FavoritesView!

    override init(store: MainStore) {
        super.init(store: store)

        favoritesView = FavoritesView(
            closeHandler: { [weak self] in self?.close() },
            toggleFavoriteForQuote: { [weak self] (quote: Quote) in
                self?.toggleFavoriteForQuote(quote: quote)
            }
        )
        self.view = favoritesView
    }

    func close() {
        dismiss(animated: true, completion: nil)
    }

    func toggleFavoriteForQuote(quote: Quote) {
        store.dispatch(ToggleFavorite(quote: quote))
    }

    override func newState(state: AppState) {
        favoritesView.updateView(viewModel: FavoritesViewModel(state: state))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
