import UIKit
import Cartography

let FavoritesCellIdentifier = "FavoritesCell"

class FavoritesView: UIView {

    let favoritesLabel = UILabel()
    let closeButton = CustomButton("X")
    let quotesTableView = UITableView()
    let closeHandler: () -> ()
    let toggleFavorite: (Int) -> ()

    var viewModel: FavoritesViewModel?

    init(closeHandler: @escaping () -> (),
        toggleFavorite: @escaping (Int) -> ()) {
        self.closeHandler = closeHandler
        self.toggleFavorite = toggleFavorite

        super.init(frame: CGRect.zero)

        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = true

        favoritesLabel.text = "Favorites"
        quotesTableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCellIdentifier)
        quotesTableView.dataSource = self
        quotesTableView.delegate = self
        quotesTableView.estimatedRowHeight = 40
        quotesTableView.rowHeight = UITableViewAutomaticDimension
        quotesTableView.separatorStyle = .none


        let subViews: [UIView] = [
            favoritesLabel,
            closeButton,
            quotesTableView
        ]
        subViews.forEach { addSubview($0) }

        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        constrain(self, favoritesLabel, closeButton, quotesTableView) {
            (containerView, favoritesLabel, closeButton, quotesTableView) in
            favoritesLabel.top == containerView.top + 30
            favoritesLabel.centerX == containerView.centerX

            closeButton.centerY == favoritesLabel.centerY
            closeButton.trailing == containerView.trailingMargin

            quotesTableView.top == favoritesLabel.bottom
            quotesTableView.leading == containerView.leading
            quotesTableView.trailing == containerView.trailing
            quotesTableView.bottom == containerView.bottom
        }
    }

    func updateView(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        self.quotesTableView.reloadData()
    }

    func closeButtonTapped() {
        closeHandler()
    }

    func toggleFavoriteTapped(quoteId: Int) {
        toggleFavorite(quoteId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FavoritesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.quotesToDisplay.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCellIdentifier, for: indexPath) as? FavoritesCell else {
            return UITableViewCell()
        }
        guard let quote = self.viewModel?.quotesToDisplay[indexPath.row] else {
            return UITableViewCell()
        }
        cell.toggleFavoriteHandler = { _ in self.toggleFavoriteTapped(quoteId: quote.id) }
        cell.updateView(viewModel: FavoritesCellViewModel(quote: quote))
        return cell
    }
}
