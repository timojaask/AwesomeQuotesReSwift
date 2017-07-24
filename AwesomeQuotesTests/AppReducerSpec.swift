import Quick
import Nimble
@testable import AwesomeQuotes

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
        }

        describe("Toggle favorite for current quote") {

            it("sets favorite to true for current quote when quote is not favorite") {
                let stateBefore = stateWithQuotes()
                let stateAfter = appReducer(action: ToggleFavoriteForCurrentQuote(), state: stateBefore)

                expect(stateBefore.quotes[stateBefore.currentQuoteIndex].isFavorite).to(equal(false))
                expect(stateAfter.quotes[stateAfter.currentQuoteIndex].isFavorite).to(equal(true))
            }

            it("sets favorite to false for current quote when quote is favorited") {
                let stateBefore = stateWithQuotes(selectFavoriteQuote: true)
                let stateAfter = appReducer(action: ToggleFavoriteForCurrentQuote(), state: stateBefore)

                expect(stateBefore.quotes[stateBefore.currentQuoteIndex].isFavorite).to(equal(true))
                expect(stateAfter.quotes[stateAfter.currentQuoteIndex].isFavorite).to(equal(false))
            }
        }

        describe("mergeFetchedQuotes") { 
            it("includes remoteQuotes when localQuotes is empty") {
                let remoteQuotes = remoteSetOfQuotes()
                let localQuotes: [Quote] = []
                let expected = remoteQuotes

                let actual = mergeFetchedQuotes(remoteQuotes: remoteQuotes, localQuotes: localQuotes)

                expect(actual).to(equal(expected))
            }

            it("does not include localQuotes that are not in remoteQuotes and are not favorite") {
                let remoteQuotes = remoteSetOfQuotes()
                let localQuotes = [randomQuote(), randomQuote()]
                let expected = remoteQuotes

                let actual = mergeFetchedQuotes(remoteQuotes: remoteQuotes, localQuotes: localQuotes)

                expect(actual).to(equal(expected))
            }

            it("includes localQuotes that are not in remoteQuotes and are favorite") {
                let remoteQuotes = remoteSetOfQuotes()
                let favoriteQuotes = [randomQuote(isFavorite: true), randomQuote(isFavorite: true)]
                let localQuotes = [randomQuote(), randomQuote()] + favoriteQuotes
                let expected = remoteQuotes + favoriteQuotes

                let actual = mergeFetchedQuotes(remoteQuotes: remoteQuotes, localQuotes: localQuotes)

                expect(actual).to(equal(expected))
            }

            it("includes isFavorite flag from localQuotes") {
                let remoteQuotes = remoteSetOfQuotes(number: 4)
                let favoriteQuotes = [remoteQuotes[0], remoteQuotes[1]].map { Quote(id: $0.id, text: $0.text, author: $0.author, isFavorite: true)
                }
                let localQuotes = favoriteQuotes + [randomQuote()]
                let expected = favoriteQuotes + [remoteQuotes[2], remoteQuotes[3]]

                let actual = mergeFetchedQuotes(remoteQuotes: remoteQuotes, localQuotes: localQuotes)

                expect(actual).to(equal(expected))
            }
        }
    }
}
