import UIKit
import Cartography
import ReSwift

class FavoritesViewController: BaseViewController {

    var favoritesView: FavoritesView!

    override init(store: MainStore) {
        super.init(store: store)

        favoritesView = FavoritesView(closeHandler: { [weak self] in self?.close() })
        self.view = favoritesView
    }

    func close() {
        dismiss(animated: true, completion: nil)
    }

    override func newState(state: AppState) {
        favoritesView.updateView(viewModel: FavoritesViewModel(state: state))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
