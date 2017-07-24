import UIKit
import Cartography

class FavoritesCell: UITableViewCell {

    let quoteTextLabel = UILabel()
    let quoteAuthorLabel = UILabel()
    let toggleFavoriteButton = UIButton()

    var toggleFavoriteHandler: (() -> ())?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let subViews: [UIView] = [
            quoteTextLabel,
            quoteAuthorLabel,
            toggleFavoriteButton,
        ]
        subViews.forEach { addSubview($0) }

        quoteTextLabel.numberOfLines = 0
        quoteAuthorLabel.numberOfLines = 1
        quoteAuthorLabel.textAlignment = .right

        toggleFavoriteButton.addTarget(self, action: #selector(toggleFavoriteButtonTapped), for: .touchUpInside)

        constrain(self, quoteTextLabel, quoteAuthorLabel, toggleFavoriteButton) {
            (containerView, quoteTextLabel, quoteAuthorLabel, toggleFavoriteButton) in
            quoteTextLabel.top == containerView.topMargin
            quoteTextLabel.leading == containerView.leadingMargin
            quoteTextLabel.trailing == containerView.trailingMargin

            toggleFavoriteButton.leading == containerView.leadingMargin
            toggleFavoriteButton.bottom == containerView.bottomMargin
            toggleFavoriteButton.height == 16
            toggleFavoriteButton.width == 16

            quoteAuthorLabel.top == quoteTextLabel.bottom + 5
            quoteAuthorLabel.leading == containerView.leadingMargin
            quoteAuthorLabel.trailing == containerView.trailingMargin
            quoteAuthorLabel.bottom == containerView.bottomMargin
        }
    }

    func toggleFavoriteButtonTapped() {
        toggleFavoriteHandler?()
    }

    func updateView(viewModel: FavoritesCellViewModel) {
        self.quoteTextLabel.text = viewModel.quoteText
        self.quoteAuthorLabel.text = viewModel.quoteAuthor
        self.toggleFavoriteButton.setImage(viewModel.favoriteButtonImage, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
