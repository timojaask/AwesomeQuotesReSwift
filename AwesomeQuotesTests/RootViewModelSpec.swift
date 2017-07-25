import Quick
import Nimble
@testable import AwesomeQuotes

class RootViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("Quote text") {

            it("has correct value when no quotes available") {
                let vm = rootViewModelWithNoQuotes()
                expect(vm.quoteText).to(equal("Loading quotes..."))
            }

            it("has current quote text") {
                let vm = rootViewModelWithQuotes()
                let expected = vm.state.quotes[vm.state.currentQuoteIndex].text
                expect(vm.quoteText).to(equal(expected))
            }
        }

        describe("Quote author") {

            it("has empty string when no quotes available") {
                let vm = rootViewModelWithNoQuotes()
                expect(vm.quoteAuthor).to(equal(""))
            }

            it("has current author") {
                let vm = rootViewModelWithQuotes()
                let expected = vm.state.quotes[vm.state.currentQuoteIndex].author
                expect(vm.quoteAuthor).to(equal(" – \(expected)"))
            }
        }

        describe("Next quote button") {

            it("hidden when there are no quotes") {
                let vm = rootViewModelWithNoQuotes()
                expect(vm.nextQuoteButtonHidden).to(equal(true))
            }

            it("visible when there are some quotes") {
                let vm = rootViewModelWithQuotes()
                expect(vm.nextQuoteButtonHidden).to(equal(false))
            }
        }

        describe("Favorite button") {

            it("hidden when there are no quotes") {
                let vm = rootViewModelWithNoQuotes()
                expect(vm.favoriteButtonHidden).to(equal(true))
            }

            it("visible when there are some quotes") {
                let vm = rootViewModelWithQuotes()
                expect(vm.favoriteButtonHidden).to(equal(false))
            }

            it("title is correct when quote has not been favorited") {
                let vm = rootViewModelWithQuotes()
                expect(vm.favoriteButtonTitle).to(equal("Add to favs"))
            }

            it("title is correct when quote has been favorited") {
                let vm = rootViewModelWithQuotes(selectFavoriteQuote: true)
                expect(vm.favoriteButtonTitle).to(equal("Remove from favs"))
            }
        }

        describe("Favorite label text") {

            it("text is correct when quote has not been favorited") {
                let vm = rootViewModelWithQuotes()
                expect(vm.isFavoriteLabelText).to(equal("not favorite"))
            }

            it("text is correct when quote has been favorited") {
                let vm = rootViewModelWithQuotes(selectFavoriteQuote: true)
                expect(vm.isFavoriteLabelText).to(equal("IS FAVORITE"))
            }
        }
    }
}
