import UIKit
import Cartography

class RootView: UIView {
    
    let quoteTextLabel = UILabel()
    let quoteAuthorLabel = UILabel()
    let isFavoriteLabel = UILabel()
    let nextQuoteButton = CustomButton("Show another")
    let favoriteButton = CustomButton("Add to favorites")
    let showFavoritesButton = CustomButton("Favorites")

    let nextQuoteHandler: () -> ()
    let favoriteQuoteHandler: () -> ()

    init(nextQuoteHandler: @escaping () -> (), favoriteQuoteHandler: @escaping () -> ()) {
        self.nextQuoteHandler = nextQuoteHandler
        self.favoriteQuoteHandler = favoriteQuoteHandler

        super.init(frame: CGRect.zero)

        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = true

        quoteTextLabel.numberOfLines = 0
        quoteAuthorLabel.textAlignment = .right
        
        let subViews: [UIView] = [
            quoteTextLabel,
            quoteAuthorLabel,
            isFavoriteLabel,
            nextQuoteButton,
            favoriteButton,
            showFavoritesButton,
        ]
        subViews.forEach { addSubview($0) }

        nextQuoteButton.addTarget(self, action: #selector(nextQuoteButtonTapped), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        showFavoritesButton.addTarget(self, action: #selector(showFavoritesButtonTapped), for: .touchUpInside)

        constrain(self, showFavoritesButton) {
            (containerView, showFavoritesButton) in
            showFavoritesButton.top == containerView.topMargin + 10
            showFavoritesButton.trailing == containerView.trailingMargin
        }

        constrain(self, quoteTextLabel, quoteAuthorLabel, isFavoriteLabel) {
            (containerView, quoteTextLabel, quoteAuthorLabel, isFavoriteLabel) in
            quoteTextLabel.centerY == containerView.centerY
            quoteTextLabel.leading == containerView.leadingMargin
            quoteTextLabel.trailing == containerView.trailingMargin

            quoteAuthorLabel.top == quoteTextLabel.bottom + 15
            quoteAuthorLabel.leading == containerView.leadingMargin
            quoteAuthorLabel.trailing == containerView.trailingMargin

            isFavoriteLabel.top == quoteAuthorLabel.bottom + 20
            isFavoriteLabel.centerX == quoteAuthorLabel.centerX
        }

        constrain(self, favoriteButton, nextQuoteButton) {
            (containerView, favoriteButton, nextQuoteButton) in
            favoriteButton.leading == containerView.leadingMargin
            favoriteButton.bottom == containerView.bottom

            nextQuoteButton.trailing == containerView.trailingMargin
            nextQuoteButton.bottom == containerView.bottom
        }
    }

    func updateView(viewModel: RootViewModel) {
        quoteTextLabel.text = viewModel.quoteText
        quoteAuthorLabel.text = viewModel.quoteAuthor
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

    func showFavoritesButtonTapped() {

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
