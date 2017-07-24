import UIKit
import Cartography

class FavoritesCell: UITableViewCell {

    let quoteTextLabel = UILabel()
    let quoteAuthorLabel = UILabel()
    let favoriteButton = UIButton()

    var favoriteButtonTapHandler: (() -> ())?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let subViews: [UIView] = [
            quoteTextLabel,
            quoteAuthorLabel,
            favoriteButton,
        ]
        subViews.forEach { addSubview($0) }

        quoteTextLabel.numberOfLines = 0
        quoteAuthorLabel.numberOfLines = 1
        quoteAuthorLabel.textAlignment = .right

        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)

        constrain(self, quoteTextLabel, quoteAuthorLabel, favoriteButton) {
            (containerView, quoteTextLabel, quoteAuthorLabel, favoriteButton) in
            quoteTextLabel.top == containerView.topMargin
            quoteTextLabel.leading == containerView.leadingMargin
            quoteTextLabel.trailing == containerView.trailingMargin

            favoriteButton.leading == containerView.leadingMargin
            favoriteButton.bottom == containerView.bottomMargin
            favoriteButton.height == 16
            favoriteButton.width == 16

            quoteAuthorLabel.top == quoteTextLabel.bottom + 5
            quoteAuthorLabel.leading == containerView.leadingMargin
            quoteAuthorLabel.trailing == containerView.trailingMargin
            quoteAuthorLabel.bottom == containerView.bottomMargin
        }
    }

    func favoriteButtonTapped() {
        favoriteButtonTapHandler?()
    }

    func updateView(viewModel: FavoritesCellViewModel) {
        self.quoteTextLabel.text = viewModel.quoteText
        self.quoteAuthorLabel.text = viewModel.quoteAuthor
        self.favoriteButton.setImage(viewModel.favoriteButtonImage, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
