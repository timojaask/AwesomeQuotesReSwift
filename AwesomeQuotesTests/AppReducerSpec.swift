import Quick
import Nimble

class AppReducerSpec: QuickSpec {
    override func spec() {
        describe("Next quote") {

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

        describe("Fetch quotes") {

            it("sets fetchQuotesState to request") {
                let stateBefore = stateWithQuotes()
                let stateAfter = appReducer(action: FetchQuotes(.request), state: stateBefore)

                expect(stateBefore.fetchQuotesState).to(equal(FetchQuotesState.none))
                expect(stateAfter.fetchQuotesState).to(equal(FetchQuotesState.request))
            }

            it("sets fetchQuotesState to success with fetched quotes array") {
                let fetchedQuotes = defaultSetOfQuotes()

                let stateBefore = stateWithQuotes()
                let stateAfter = appReducer(action: FetchQuotes(.success(quotes: fetchedQuotes)), state: stateBefore)

                expect(stateBefore.fetchQuotesState).to(equal(FetchQuotesState.none))
                expect(stateAfter.fetchQuotesState).to(equal(FetchQuotesState.success(quotes: fetchedQuotes)))
            }

            it("sets fetchedQuotesState to error") {
                enum TestError: Error {
                    case someOtherError
                    case someError
                }

                let stateBefore = stateWithQuotes()
                let stateAfter = appReducer(action: FetchQuotes(.error(error: TestError.someError)), state: stateBefore)

                expect(stateBefore.fetchQuotesState).to(equal(FetchQuotesState.none))
                expect(stateAfter.fetchQuotesState).to(equal(FetchQuotesState.error(error: TestError.someError)))
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
