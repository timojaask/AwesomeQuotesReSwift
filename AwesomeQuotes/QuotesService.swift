import Foundation
import PromiseKit

let url = "https://jsonblob.com/api/jsonBlob/9ab95547-5a75-11e7-ae4c-9f9f5af9ecc0"

protocol QuotesService {
    func getQuotes() -> Promise<[Quote]>
}

struct RemoteQuotesService: QuotesService {
    func getQuotes() -> Promise<[Quote]> {
        let debugQuotes = (1...10).map { index -> Quote in
            return Quote(text: "Quote \(index)", author: "Author \(index)")
        }
        return Promise.init(value: debugQuotes)
    }
}
