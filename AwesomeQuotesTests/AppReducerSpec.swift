import Quick
import Nimble

class AppReducerSpec: QuickSpec {
    override func spec() {
        describe("Next quote action") {

            it("increments current quote index") {
                let stateBefore = stateWithQuotes()
                let stateAfter = appReducer(action: NextQuote(), state: stateBefore)

                expect(stateBefore.currentQuoteIndex).to(equal(0))
                expect(stateAfter.currentQuoteIndex).to(equal(1))
            }

            it("resets current quote index after last quote") {
                let stateBefore = stateWithQuotes()
                let stateInBetween = appReducer(action: NextQuote(), state: stateBefore)
                let stateAfter = appReducer(action: NextQuote(), state: stateInBetween)
                
                expect(stateBefore.currentQuoteIndex).to(equal(0))
                expect(stateInBetween.currentQuoteIndex).to(equal(1))
                expect(stateAfter.currentQuoteIndex).to(equal(0))
            }

            it("does nothing when there are no quotes") {
                let stateBefore = stateWithNoQuotes()
                let stateAfter = appReducer(action: NextQuote(), state: stateBefore)
                
                expect(stateBefore).to(equal(stateAfter))
            }

            it("sets current quote to the next quote in the quotes array") {
                let stateBefore = stateWithQuotes()
                let expectedNextQuote = stateBefore.quotes[stateBefore.currentQuoteIndex + 1]
                let stateAfter = appReducer(action: NextQuote(), state: stateBefore)

                expect(stateAfter.currentQuote).to(equal(expectedNextQuote))
            }
        }

        describe("Set quotes action") {

            it("replaces old quotes with new ones") {
                let newQuotes = anotherSetOfQuotes()
                let stateBefore = stateWithQuotes()
                let stateAfter = appReducer(
                    action: SetQuotes(quotes: newQuotes),
                    state: stateBefore)

                expect(stateBefore.quotes).toNot(equal(stateAfter.quotes))
                expect(stateAfter.quotes).to(equal(newQuotes))
            }

            it("sets current quote to first quote if there were previously no quotes") {
                let newQuotes = anotherSetOfQuotes()
                let stateBefore = stateWithNoQuotes()
                let stateAfter = appReducer(
                    action: SetQuotes(quotes: newQuotes),
                    state: stateBefore)

                expect(stateBefore.currentQuoteIndex).to(equal(-1))
                expect(stateBefore.currentQuote).to(beNil())

                expect(stateAfter.currentQuoteIndex).to(equal(0))
                expect(stateAfter.currentQuote).to(equal(newQuotes[0]))
            }

            it("should not change current quote if there were quotes already") {
                let newQuotes = anotherSetOfQuotes()
                let stateBefore = stateWithQuotes(selectFavoriteQuote: true)
                let stateAfter = appReducer(
                    action: SetQuotes(quotes: newQuotes),
                    state: stateBefore)

                expect(stateBefore.currentQuoteIndex).to(equal(favoriteQuoteIndexInDefaultSet))

                expect(stateAfter.currentQuoteIndex).to(equal(stateBefore.currentQuoteIndex))
                expect(stateAfter.currentQuote).to(equal(stateBefore.currentQuote))
            }
        }

        describe("Fetching quotes") {

            it("sets fetching quotes to the same value as passed in the action parameter") {
                let stateBefore = stateWithQuotes()
                let stateInBetween = appReducer(action: SetFetchingQuotes(fetching: true), state: stateBefore)
                let stateAfter = appReducer(action: SetFetchingQuotes(fetching: false), state: stateInBetween)

                expect(stateBefore.fetchingQuotes).to(equal(false))
                expect(stateInBetween.fetchingQuotes).to(equal(true))
                expect(stateAfter.fetchingQuotes).to(equal(false))
            }
        }

        describe("Toggle favorite for current quote") {

            it("sets favorite to true for current quote when quote is not favorite") {
                let stateBefore = stateWithQuotes()
                let stateAfter = appReducer(action: ToggleFavoriteForCurrentQuote(), state: stateBefore)

                expect(stateBefore.currentQuote?.isFavorite).to(equal(false))
                expect(stateAfter.currentQuote?.isFavorite).to(equal(true))
            }

            it("sets favorite to false for current quote when quote is favorited") {
                let stateBefore = stateWithQuotes(selectFavoriteQuote: true)
                let stateAfter = appReducer(action: ToggleFavoriteForCurrentQuote(), state: stateBefore)

                expect(stateBefore.currentQuote?.isFavorite).to(equal(true))
                expect(stateAfter.currentQuote?.isFavorite).to(equal(false))
            }
        }
    }
}
