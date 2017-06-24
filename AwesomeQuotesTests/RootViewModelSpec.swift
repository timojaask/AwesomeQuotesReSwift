import Quick
import Nimble

class RootViewModelSpec: QuickSpec {

    override func spec() {
        describe("Quote text") {

            it("has correct value when no quotes available") {
                let vm = viewModelWithNoQuotes()
                expect(vm.quoteText).to(equal("No quotes to display"))
            }

            it("has current quote text") {
                let vm = viewModelWithQuotes()
                expect(vm.quoteText).to(equal(vm.state.currentQuote!.text))
            }
        }

        describe("Quote author") {

            it("has empty string when no quotes available") {
                let vm = viewModelWithNoQuotes()
                expect(vm.quoteAuthor).to(equal(""))
            }

            it("has current author") {
                let vm = viewModelWithQuotes()
                expect(vm.quoteAuthor).to(equal(" – \(vm.state.currentQuote!.author)"))
            }
        }

        describe("Next quote button") {

            it("hidden when there are no quotes") {
                let vm = viewModelWithNoQuotes()
                expect(vm.nextQuoteButtonHidden).to(equal(true))
            }

            it("visible when there are some quotes") {
                let vm = viewModelWithQuotes()
                expect(vm.nextQuoteButtonHidden).to(equal(false))
            }
        }

        describe("Favorite button") {

            it("hidden when there are no quotes") {
                let vm = viewModelWithNoQuotes()
                expect(vm.favoriteButtonHidden).to(equal(true))
            }

            it("visible when there are some quotes") {
                let vm = viewModelWithQuotes()
                expect(vm.favoriteButtonHidden).to(equal(false))
            }

            it("title is correct when quote has not been favorited") {
                let vm = viewModelWithQuotes()
                expect(vm.favoriteButtonTitle).to(equal("Add to favs"))
            }

            it("title is correct when quote has been favorited") {
                let vm = viewModelWithQuotes(selectFavoriteQuote: true)
                expect(vm.favoriteButtonTitle).to(equal("Remove from favs"))
            }
        }

        describe("Favorite label text") {

            it("text is correct when quote has not been favorited") {
                let vm = viewModelWithQuotes()
                expect(vm.isFavoriteLabelText).to(equal("not favorite"))
            }

            it("text is correct when quote has been favorited") {
                let vm = viewModelWithQuotes(selectFavoriteQuote: true)
                expect(vm.isFavoriteLabelText).to(equal("IS FAVORITE"))
            }
        }
    }
}
