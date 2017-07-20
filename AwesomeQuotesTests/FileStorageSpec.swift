import Quick
import Nimble
import PromiseKit
@testable import AwesomeQuotes

class FileStorageSpec: QuickSpec {
    override func spec() {
        describe("AppStateCodable") {

            it("init with AppState sets quotes and currentQuoteIndex") {
                let quotes = defaultSetOfQuotes()
                let currentQuoteIndex = 1
                let expected = AppState(quotes: quotes, currentQuoteIndex: currentQuoteIndex, fetchQuotesState: .none)

                let actual = AppStateCodable(appState: expected)

                expect(actual.quotes).to(equal(expected.quotes))
                expect(actual.currentQuoteIndex).to(equal(expected.currentQuoteIndex))
            }

            it("init with quote and currentQuoteIndex sets the same named properties") {
                let quotes = defaultSetOfQuotes()
                let currentQuoteIndex = 1
                let expected = AppState(quotes: quotes, currentQuoteIndex: currentQuoteIndex, fetchQuotesState: .none)

                let actual = AppStateCodable(quotes: quotes, currentQuoteIndex: currentQuoteIndex)

                expect(actual.quotes).to(equal(expected.quotes))
                expect(actual.currentQuoteIndex).to(equal(expected.currentQuoteIndex))
            }

            it("toAppState sets correct quote and currentQuoteIndex") {
                let expected = AppState(quotes: defaultSetOfQuotes(), currentQuoteIndex: 1, fetchQuotesState: .none)

                let actual = AppStateCodable(appState: expected).toAppState()

                expect(actual.quotes).to(equal(expected.quotes))
                expect(actual.currentQuoteIndex).to(equal(expected.currentQuoteIndex))
            }

            it("Encoding and decoding with NSCoder preserves the original AppState") {
                let quotes = remoteSetOfQuotes(number: 4)
                let expected = AppState(quotes: quotes, currentQuoteIndex: 1, fetchQuotesState: .none)

                let codable = AppStateCodable(appState: expected)

                let archived = NSKeyedArchiver.archivedData(withRootObject: codable)
                let unarchived = NSKeyedUnarchiver.unarchiveObject(with: archived) as? AppStateCodable

                let actual = unarchived?.toAppState()

                expect(actual).to(equal(expected))
            }
        }

        describe("QuoteCodable") {
            it("init with Quote sets all properties") {
                let expected = randomQuote(isFavorite: true)
                let actual = QuoteCodable(quote: expected)

                expect(actual.text).to(equal(expected.text))
                expect(actual.author).to(equal(expected.author))
                expect(actual.isFavorite).to(equal(expected.isFavorite))
            }

            it("init with parameters sets all properties") {
                let expected = randomQuote(isFavorite: false)
                let actual = QuoteCodable(text: expected.text, author: expected.author, isFavorite: expected.isFavorite)

                expect(actual.text).to(equal(expected.text))
                expect(actual.author).to(equal(expected.author))
                expect(actual.isFavorite).to(equal(expected.isFavorite))
            }

            it("toQuote retuns quote with correct properties") {
                let expected = randomQuote(isFavorite: true)
                let actual = QuoteCodable(quote: expected).toQuote()

                expect(actual).to(equal(expected))
            }

            it("Encoding and decoding with NSCoder preserves te original Quote") {
                let expected = randomQuote(isFavorite: false)

                let codable = QuoteCodable(quote: expected)
                let archived = NSKeyedArchiver.archivedData(withRootObject: codable)
                let unarchived = NSKeyedUnarchiver.unarchiveObject(with: archived) as? QuoteCodable

                let actual = unarchived?.toQuote()

                expect(actual).to(equal(expected))
            }
        }

        describe("FileStorage") { 
            // This is an integration test that doesn't try to mock out the actual file system I/O
            let testStorageFileName = "AwesomeQuotesTests-appState"

            beforeEach {
                clearLocalStorage(fileName: testStorageFileName)
            }

            afterEach {
                clearLocalStorage(fileName: testStorageFileName)
            }


            it("Writing and reading AppState to FileStorage preserves all properties") {
                let quotes = defaultSetOfQuotes()
                let currentQuoteIndex = 1
                let expected = AppState(quotes: quotes, currentQuoteIndex: currentQuoteIndex, fetchQuotesState: .none)

                var actual: AppState?

                let fileStorage = FileStorage(fileName: testStorageFileName)

                func handleError(error: Error) {
                    fail("loadState failed with error: \(error.localizedDescription)")
                }

                func loadState() {
                    fileStorage.loadState()
                        .then { appState -> Void in
                            actual = appState
                        }
                        .catch(execute: handleError)
                }

                fileStorage.saveState(state: expected)
                    .then(execute: loadState)
                    .catch(execute: handleError)

                expect(actual).toEventually(equal(expected), timeout: 1)
            }
        }
    }
}

func clearLocalStorage(fileName: String) {
    try? FileManager.default.removeItem(atPath: FileStorage.filePath(fileName))
}
