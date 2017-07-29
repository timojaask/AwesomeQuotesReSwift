import Quick
import Nimble
import PromiseKit
@testable import AwesomeQuotes

class JsonSerializationSpec: QuickSpec {

    static let sampleQuotes = [
        Quote(id: 0, text: "testText1", author: "testAuthor1"),
        Quote(id: 1, text: "testText2", author: "testAuthor2"),
        Quote(id: 2, text: "testText3", author: "testAuthor3"),
    ]

    static var sampleQuotesJson: [[String:Any]] {
        return sampleQuotes.toJson()
    }

    override func spec() {
        describe("Quote") {

            describe("fromJson") {

                it("returns a valid quote object when isFavorite is not provided") {
                    let expected = Quote(id: 0, text: "testText1", author: "testAuthor1", isFavorite: false)
                    let json: [String: Any] =  [
                        "id": expected.id,
                        "text": expected.text,
                        "author": expected.author
                    ]
                    let actual = try? Quote.fromJson(json: json)

                    expect(actual).to(equal(expected))
                }

                it("returns a valid quote object when isFavorite is provided") {
                    let expected = Quote(id: 0, text: "testText1", author: "testAuthor1", isFavorite: true)
                    let json: [String: Any] =  [
                        "id": expected.id,
                        "text": expected.text,
                        "author": expected.author,
                        "isFavorite": expected.isFavorite
                    ]
                    let actual = try? Quote.fromJson(json: json)

                    expect(actual).to(equal(expected))
                }

                it("throws an error on json dictionary being incorrect type") {
                    let input = [["text": "testText"]]
                    let expected = JsonSerializationError.JsonParsingError

                    expect { try Quote.fromJson(json: input) }.to(throwError(expected))
                }

                it("throws an error on missing ID parameter") {
                    let input: [String: Any] =  [
                        "text": "testText1",
                        "author": "testAuthor1"
                    ]
                    let expected = JsonSerializationError.JsonParsingError

                    expect { try Quote.fromJson(json: input) }.to(throwError(expected))
                }

                it("throws an error on missing text parameter") {
                    let input: [String: Any] =  [
                        "id": 0,
                        "author": "testAuthor1"
                    ]
                    let expected = JsonSerializationError.JsonParsingError

                    expect { try Quote.fromJson(json: input) }.to(throwError(expected))
                }

                it("throws an error on missing author parameter") {
                    let input: [String: Any] =  [
                        "id": 0,
                        "text": "testText1"
                    ]
                    let expected = JsonSerializationError.JsonParsingError

                    expect { try Quote.fromJson(json: input) }.to(throwError(expected))
                }
            }
        }

        describe("Quote array") {

            describe("jsonToQuotes") {

                it("returns a valid quotes array") {

                    let input = JsonSerializationSpec.sampleQuotesJson
                    let expected = JsonSerializationSpec.sampleQuotes
                    let actual = try? jsonToQuotes(input)

                    expect(actual).to(equal(expected))
                }

                it("throws an error when json is not an array") {
                    let input: [String: Any] =  [
                        "id": 0,
                        "text": "testText1",
                        "author": "testAuthor1"
                    ]
                    let expected = JsonSerializationError.JsonParsingError

                    expect { try jsonToQuotes(input) }.to(throwError(expected))
                }
            }
        }
    }
}
