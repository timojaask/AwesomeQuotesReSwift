import Foundation
import PromiseKit

let url = "https://jsonblob.com/api/jsonBlob/9ab95547-5a75-11e7-ae4c-9f9f5af9ecc0"

protocol QuotesService {
    func getQuotes() -> Promise<[Quote]>
}

enum QuotesServiceError: Error {
    case JsonParsingError
}

struct RemoteQuotesService: QuotesService {
    let networkService: NetworkService

    func getQuotes() -> Promise<[Quote]> {
        return networkService.fetchJson(url)
            .then(execute: convertJsonToQuotes)
    }
}

func convertJsonToQuotes(_ json: Any) throws -> [Quote] {
    guard let jsonArray = json as? [Any] else {
        throw QuotesServiceError.JsonParsingError
    }
    let result = try jsonArray.map(Quote.fromJson)
    return result
}

extension Quote {
    static func fromJson(json: Any) throws -> Quote {
        guard let jsonDictionary = json as? [String: String] else {
            throw QuotesServiceError.JsonParsingError
        }
        guard let text = jsonDictionary["text"] else {
            throw QuotesServiceError.JsonParsingError
        }
        guard let author = jsonDictionary["author"] else {
            throw QuotesServiceError.JsonParsingError
        }
        return Quote(text: text, author: author)
    }
}
