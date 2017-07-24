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

            it("fromJson returns a valid quote object") {

                let input = JsonSerializationSpec.sampleQuotesJson.first!
                let expected = JsonSerializationSpec.sampleQuotes.first!
                let actual = try? Quote.fromJson(json: input)

                expect(actual).to(equal(expected))
            }

            it("fromJson throws an error on invalid json") {

                let input = ["text": "testText"]
                let expected = JsonSerializationError.JsonParsingError

                expect { try Quote.fromJson(json: input) }.to(throwError(expected))
            }
        }

        describe("Quote array") {

            it("jsonToQuotes returns a valid quotes array") {

                let input = JsonSerializationSpec.sampleQuotesJson
                let expected = JsonSerializationSpec.sampleQuotes
                let actual = try? jsonToQuotes(input)

                expect(actual).to(equal(expected))
            }
        }
    }
}
