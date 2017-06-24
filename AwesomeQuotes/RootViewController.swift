import UIKit
import Cartography
import ReSwift

class RootViewController: BaseViewController {

    var rootView: RootView!

    override init(store: MainStore) {
        super.init(store: store)

        rootView = RootView(
            nextQuoteHandler: { [weak self] in self?.nextQuote() },
            favoriteQuoteHandler: { [weak self] in self?.favoriteQuote() }
        )
        self.view = rootView
    }

    func nextQuote() {
        store.dispatch(NextQuote())
    }

    func favoriteQuote() {
        store.dispatch(ToggleFavoriteForCurrentQuote())
    }

    override func newState(state: AppState) {
        rootView.updateView(viewModel: RootViewModel(state: state))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
