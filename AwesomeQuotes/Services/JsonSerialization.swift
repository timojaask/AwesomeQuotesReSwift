import Foundation

enum JsonSerializationError: Error {
    case JsonParsingError
}

extension Quote {
    static func fromJson(json: Any) throws -> Quote {
        guard let jsonDictionary = json as? [String: Any] else {
            throw JsonSerializationError.JsonParsingError
        }
        guard let id = jsonDictionary["id"] as? Int else {
            throw JsonSerializationError.JsonParsingError
        }
        guard let text = jsonDictionary["text"] as? String else {
            throw JsonSerializationError.JsonParsingError
        }
        guard let author = jsonDictionary["author"] as? String else {
            throw JsonSerializationError.JsonParsingError
        }
        if let isFavorite = jsonDictionary["isFavorite"] as? Bool {
            return Quote(id: id, text: text, author: author, isFavorite: isFavorite)
        }
        return Quote(id: id, text: text, author: author)
    }
}

func jsonToQuotes(_ json: Any) throws -> [Quote] {
    guard let jsonArray = json as? [Any] else {
        throw JsonSerializationError.JsonParsingError
    }
    return try jsonArray.map(Quote.fromJson)
}
