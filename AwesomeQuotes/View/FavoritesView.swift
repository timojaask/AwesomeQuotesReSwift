import UIKit
import Cartography

class FavoritesView: UIView {

    let favoritesLabel = UILabel()
    let closeButton = CustomButton("X")

    let closeHandler: () -> ()

    init(closeHandler: @escaping () -> ()) {
        self.closeHandler = closeHandler

        super.init(frame: CGRect.zero)

        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = true
        favoritesLabel.text = "Favorites"

        let subViews: [UIView] = [
            favoritesLabel,
            closeButton,
        ]
        subViews.forEach { addSubview($0) }

        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        constrain(self, favoritesLabel, closeButton) {
            (containerView, favoritesLabel, closeButton) in
            favoritesLabel.top == containerView.topMargin + 20
            favoritesLabel.centerX == containerView.centerX

            closeButton.top == containerView.topMargin + 20
            closeButton.trailing == containerView.trailingMargin
        }
    }

    func updateView(viewModel: FavoritesViewModel) {
    }

    func closeButtonTapped() {
        closeHandler()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
