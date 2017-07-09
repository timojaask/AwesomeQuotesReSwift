import Quick
import Nimble
import PromiseKit

class FileStorageSpec: QuickSpec {
    override func spec() {
        describe("AppStateCodable") {

            it("init with AppState sets quotes and currentQuoteIndex") {
                let quotes = defaultSetOfQuotes()
                let currentQuoteIndex = 1
                let expected = AppState(quotes: quotes, currentQuoteIndex: currentQuoteIndex, currentQuote: nil, fetchQuotesState: .none)

                let actual = AppStateCodable(appState: expected)

                expect(actual.quotes).to(equal(expected.quotes))
                expect(actual.currentQuoteIndex).to(equal(expected.currentQuoteIndex))
            }

            it("init with quote and currentQuoteIndex sets the same named properties") {
                let quotes = defaultSetOfQuotes()
                let currentQuoteIndex = 1
                let expected = AppState(quotes: quotes, currentQuoteIndex: currentQuoteIndex, currentQuote: nil, fetchQuotesState: .none)

                let actual = AppStateCodable(quotes: quotes, currentQuoteIndex: currentQuoteIndex)

                expect(actual.quotes).to(equal(expected.quotes))
                expect(actual.currentQuoteIndex).to(equal(expected.currentQuoteIndex))
            }

            it("toAppState sets correct quote and currentQuoteIndex") {
                let expected = AppState(quotes: defaultSetOfQuotes(), currentQuoteIndex: 1, currentQuote: nil, fetchQuotesState: .none)

                let actual = AppStateCodable(appState: expected).toAppState()

                expect(actual.quotes).to(equal(expected.quotes))
                expect(actual.currentQuoteIndex).to(equal(expected.currentQuoteIndex))
            }

            it("toAppState sets currentQuote to nil when quotes is empty") {
                let actual = AppStateCodable(quotes: [], currentQuoteIndex: 0).toAppState()
                expect(actual.currentQuote).to(beNil())
            }

            it("toAppState sets currentQuote to nil when currentQuoteIndex is below 0") {
                let actual = AppStateCodable(quotes: remoteSetOfQuotes(), currentQuoteIndex: -1).toAppState()

                expect(actual.currentQuote).to(beNil())
            }

            it("toAppState sets currentQuote if quotes is not empty and currentQuoteIndex is 0 or larger") {
                let expected = randomQuote()
                let quotes: [Quote] = remoteSetOfQuotes(number: 2) + [expected]
                let actual = AppStateCodable(quotes: quotes, currentQuoteIndex: 2).toAppState().currentQuote

                expect(actual).to(equal(expected))
            }

            it("Encoding and decoding with NSCoder preserves the original AppState") {
                let quotes = remoteSetOfQuotes(number: 4)
                let expected = AppState(quotes: quotes, currentQuoteIndex: 1, currentQuote: quotes[1], fetchQuotesState: .none)

                let codable = AppStateCodable(appState: expected)

                let archived = NSKeyedArchiver.archivedData(withRootObject: codable)
                let unarchived = NSKeyedUnarchiver.unarchiveObject(with: archived) as? AppStateCodable

                let actual = unarchived?.toAppState()

                expect(actual).to(equal(expected))
            }
        }
    }
}
