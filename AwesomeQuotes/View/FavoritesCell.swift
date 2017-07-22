import UIKit
import Cartography

class FavoritesCell: UITableViewCell {

    let quoteTextLabel = UILabel()
    let quoteAuthorLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let subViews: [UIView] = [
            quoteTextLabel,
            quoteAuthorLabel,
        ]
        subViews.forEach { addSubview($0) }

        quoteTextLabel.numberOfLines = 0
        quoteAuthorLabel.numberOfLines = 1
        quoteAuthorLabel.textAlignment = .right

        constrain(self, quoteTextLabel, quoteAuthorLabel) {
            (containerView, quoteTextLabel, quoteAuthorLabel) in
            quoteTextLabel.top == containerView.topMargin
            quoteTextLabel.leading == containerView.leadingMargin
            quoteTextLabel.trailing == containerView.trailingMargin

            quoteAuthorLabel.top == quoteTextLabel.bottom + 5
            quoteAuthorLabel.leading == containerView.leadingMargin
            quoteAuthorLabel.trailing == containerView.trailingMargin
            quoteAuthorLabel.bottom == containerView.bottomMargin
        }
    }

    func updateView(viewModel: FavoritesCellViewModel) {
        self.quoteTextLabel.text = viewModel.quoteText
        self.quoteAuthorLabel.text = viewModel.quoteAuthor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
