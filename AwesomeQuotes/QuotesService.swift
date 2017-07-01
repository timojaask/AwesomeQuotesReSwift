import Foundation
import PromiseKit
import Alamofire

let url = "https://jsonblob.com/api/jsonBlob/9ab95547-5a75-11e7-ae4c-9f9f5af9ecc0"

protocol QuotesService {
    func getQuotes() -> Promise<[Quote]>
}

func convertJsonToQuotes(_ json: Any) throws -> [Quote] {
    guard let jsonArray = json as? [Any] else {
        throw QuotesServiceError.JsonParsingError
    }
    return try jsonArray.map(Quote.fromJson)
}

enum QuotesServiceError: Error {
    case JsonParsingError
}

struct RemoteQuotesService: QuotesService {
    func getQuotes() -> Promise<[Quote]> {
        return Alamofire.request(url)
            .responseJSON()
            .then(execute: convertJsonToQuotes)
    }
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
