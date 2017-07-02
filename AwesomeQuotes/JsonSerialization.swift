import Foundation

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
        return [ "text": text, "author": author ]
    }
}

extension Quote {
    static func fromJson(json: Any) throws -> Quote {
        guard let jsonDictionary = json as? [String: String] else {
            throw JsonSerializationError.JsonParsingError
        }
        guard let text = jsonDictionary["text"] else {
            throw JsonSerializationError.JsonParsingError
        }
        guard let author = jsonDictionary["author"] else {
            throw JsonSerializationError.JsonParsingError
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
