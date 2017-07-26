import Quick
import Nimble
@testable import AwesomeQuotes

class FavoritesViewModelSpec: QuickSpec {

    override func spec() {
        describe("init") {
            it("sets quotesToDisplay to quotes listed in initialQuoteIds") {
                let favoriteQuotes = randomQuotes(number: 4, isFavorite: true)
                let allQuotes = (randomQuotes() + favoriteQuotes) + randomQuotes()
                let state = AppState(quotes: allQuotes, currentQuoteIndex: 0)

                let initialQuoteIds = favoriteQuotes.map { $0.id }

                let vm = FavoritesViewModel(state: state, initialQuoteIds: initialQuoteIds)

                expect(vm.quotesToDisplay).to(equal(favoriteQuotes))
            }
        }

        describe("getFavoriteQuoteIds") {
            it("returns ID's of favorite quotes") {
                let favoriteQuotes = randomQuotes(number: 4, isFavorite: true)
                let allQuotes = (randomQuotes() + favoriteQuotes) + randomQuotes()

                let expected = favoriteQuotes.map { $0.id }
                let actual = FavoritesViewModel.getFavoriteQuoteIds(quotes: allQuotes)

                expect(actual).to(equal(expected))
            }
        }
    }
}
