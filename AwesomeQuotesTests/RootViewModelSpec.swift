import Quick
import Nimble
@testable import AwesomeQuotes

class RootViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("quoteText") {

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

        describe("quoteAuthor") {

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

        describe("nextQuoteButtonHidden") {

            it("returns true when there are no quotes") {
                let vm = rootViewModelWithNoQuotes()
                expect(vm.nextQuoteButtonHidden).to(equal(true))
            }

            it("returns false when there are some quotes") {
                let vm = rootViewModelWithQuotes()
                expect(vm.nextQuoteButtonHidden).to(equal(false))
            }
        }

        describe("favoriteButtonHidden") {

            it("returns true when there are no quotes") {
                let vm = rootViewModelWithNoQuotes()
                expect(vm.favoriteButtonHidden).to(equal(true))
            }

            it("returns false when there are some quotes") {
                let vm = rootViewModelWithQuotes()
                expect(vm.favoriteButtonHidden).to(equal(false))
            }
        }

        describe("favoriteButtonTitle") {

            it("is correct when quote has not been favorited") {
                let vm = rootViewModelWithQuotes()
                expect(vm.favoriteButtonTitle).to(equal("Add to favs"))
            }

            it("is correct when quote has been favorited") {
                let vm = rootViewModelWithQuotes(selectFavoriteQuote: true)
                expect(vm.favoriteButtonTitle).to(equal("Remove from favs"))
            }
        }

        describe("isFavoriteLabelText") {

            it("is correct when quote has not been favorited") {
                let vm = rootViewModelWithQuotes()
                expect(vm.isFavoriteLabelText).to(equal("not favorite"))
            }

            it("is correct when quote has been favorited") {
                let vm = rootViewModelWithQuotes(selectFavoriteQuote: true)
                expect(vm.isFavoriteLabelText).to(equal("IS FAVORITE"))
            }
        }
    }
}
