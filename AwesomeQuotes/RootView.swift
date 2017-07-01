import UIKit
import Cartography

class RootView: UIView {
    
    let quoteTextLabel = UILabel()
    let isFavoriteLabel = UILabel()
    let nextQuoteButton = CustomButton("Show another")
    let favoriteButton = CustomButton("Add to favorites")

    let nextQuoteHandler: () -> ()
    let favoriteQuoteHandler: () -> ()

    init(nextQuoteHandler: @escaping () -> (), favoriteQuoteHandler: @escaping () -> ()) {
        self.nextQuoteHandler = nextQuoteHandler
        self.favoriteQuoteHandler = favoriteQuoteHandler

        super.init(frame: CGRect.zero)

        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = true
        
        let subViews: [UIView] = [
            quoteTextLabel,
            isFavoriteLabel,
            nextQuoteButton,
            favoriteButton
        ]
        subViews.forEach { addSubview($0) }

        nextQuoteButton.addTarget(self, action: #selector(nextQuoteButtonTapped), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)

        constrain(self, quoteTextLabel, isFavoriteLabel, favoriteButton, nextQuoteButton) {
            (containerView, quoteTextLabel, isFavoriteLabel, favoriteButton, nextQuoteButton) in
            quoteTextLabel.center == containerView.center

            isFavoriteLabel.top == quoteTextLabel.bottom + 20
            isFavoriteLabel.centerX == quoteTextLabel.centerX

            favoriteButton.left == containerView.left
            favoriteButton.bottom == containerView.bottom

            nextQuoteButton.right == containerView.right
            nextQuoteButton.bottom == containerView.bottom
        }
    }

    func updateView(viewModel: RootViewModel) {
        quoteTextLabel.text = viewModel.quoteText
        isFavoriteLabel.text = viewModel.isFavoriteLabelText
        nextQuoteButton.isHidden = viewModel.nextQuoteButtonHidden
        favoriteButton.isHidden = viewModel.favoriteButtonHidden
        favoriteButton.setTitle(viewModel.favoriteButtonTitle, for: .normal)
    }

    func nextQuoteButtonTapped() {
        nextQuoteHandler()
    }

    func favoriteButtonTapped() {
        favoriteQuoteHandler()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
