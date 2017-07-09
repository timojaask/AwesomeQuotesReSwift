import Foundation

// TODO: Cleanup - not everything here is used outside of unit tests

enum JsonSerializationError: Error {
    case JsonParsingError
}

extension Array where Element == Quote {
    func toJson() -> Any {
        return self.map { $0.toJson() }
    }
}

extension Quote {
    func toJson() -> Any {
        return [ "text": text, "author": author, "isFavorite": isFavorite ]
    }
}

extension Quote {
    static func fromJson(json: Any) throws -> Quote {
        guard let jsonDictionary = json as? [String: Any] else {
            throw JsonSerializationError.JsonParsingError
        }
        guard let text = jsonDictionary["text"] as? String else {
            throw JsonSerializationError.JsonParsingError
        }
        guard let author = jsonDictionary["author"] as? String else {
            throw JsonSerializationError.JsonParsingError
        }
        if let isFavorite = jsonDictionary["isFavorite"] as? Bool {
            return Quote(text: text, author: author, isFavorite: isFavorite)
        }
        return Quote(text: text, author: author)
    }
}

func jsonToQuotes(_ json: Any) throws -> [Quote] {
    guard let jsonArray = json as? [Any] else {
        throw JsonSerializationError.JsonParsingError
    }
    return try jsonArray.map(Quote.fromJson)
}

// TODO: Unit test
extension AppState {
    func toJson() -> Any {
        print("toJson: idx: \(self.currentQuoteIndex)")
        return [
            "quotes": self.quotes.toJson(),
            "currentQuoteIndex": self.currentQuoteIndex,
        ]
    }

    static func fromJson(json: Any) throws -> AppState {
        guard let jsonDictionary = json as? [String: Any] else {
            throw JsonSerializationError.JsonParsingError
        }
        guard let quotesJson = jsonDictionary["quotes"] else {
            throw JsonSerializationError.JsonParsingError
        }
        let quotes = try jsonToQuotes(quotesJson)
        guard let currentQuoteIndex = jsonDictionary["currentQuoteIndex"] as? Int else {
            throw JsonSerializationError.JsonParsingError
        }
        print("fromJson: idx: \(currentQuoteIndex)")
        return AppState(
            quotes: quotes,
            currentQuoteIndex: currentQuoteIndex,
            currentQuote: quotes[currentQuoteIndex],
            fetchQuotesState: .none
        )
    }
}
