import Quick
import Nimble
import PromiseKit
@testable import AwesomeQuotes

class JsonSerializationSpec: QuickSpec {

    static let sampleQuotes = [
        Quote(text: "testText1", author: "testAuthor1"),
        Quote(text: "testText2", author: "testAuthor2"),
        Quote(text: "testText3", author: "testAuthor3"),
    ]

    static var sampleQuotesJson: [[String:String]] {
        return sampleQuotes.map { ["text": $0.text, "author": $0.author] }
    }

    override func spec() {
        describe("Quote") {

            it("toJson returns a valid json object") {

                let input = JsonSerializationSpec.sampleQuotes.first!
                let expected = JsonSerializationSpec.sampleQuotesJson.first!
                let actual = input.toJson() as? [String:String]

                expect(actual).to(equal(expected))
            }

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

            it("toJson returns a valid json object") {

                let input = JsonSerializationSpec.sampleQuotes
                let expected = JsonSerializationSpec.sampleQuotesJson
                let actual = input.toJson() as? [[String:String]]

                expect(actual).to(equal(expected))
            }

            it("jsonToQuotes returns a valid quotes array") {

                let input = JsonSerializationSpec.sampleQuotesJson
                let expected = JsonSerializationSpec.sampleQuotes
                let actual = try? jsonToQuotes(input)

                expect(actual).to(equal(expected))
            }
        }
    }
}

// Nimble is not able to test [[String:String]] for equality out of the box, so
// here's a custom equality matcher for this type.
public func equal(_ expectedValue: [[String:String]]) -> Predicate<[[String:String]]> {
    return Predicate.define("equal <\(stringify(expectedValue))>") { actualExpression, msg in
        let actualValueOptional = try actualExpression.evaluate()
        guard let actualValue = actualValueOptional else {
            return PredicateResult(status: PredicateStatus(bool: false), message: msg)
        }
        guard actualValue.count == expectedValue.count else {
            return PredicateResult(status: PredicateStatus(bool: false), message: msg)
        }
        var matches = true
        for i in 0..<expectedValue.count {
            if actualValue[i] != expectedValue[i] {
                matches = false
            }
        }
        return PredicateResult(status: PredicateStatus(bool: matches), message: msg)
    }
}
