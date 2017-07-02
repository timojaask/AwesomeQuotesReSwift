import Foundation
import PromiseKit

let url = "https://jsonblob.com/api/jsonBlob/9ab95547-5a75-11e7-ae4c-9f9f5af9ecc0"

protocol QuotesService {
    func getQuotes() -> Promise<[Quote]>
}

struct RemoteQuotesService: QuotesService {
    let networkService: NetworkService

    func getQuotes() -> Promise<[Quote]> {
        return networkService.fetchJson(url)
            .then(execute: jsonToQuotes)
    }
}
