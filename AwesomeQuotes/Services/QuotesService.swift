import Foundation
import PromiseKit

let url = "https://jsonblob.com/api/jsonBlob/16fa9170-706f-11e7-9e0d-1bb120f11060"

protocol QuotesService {
    func fetchQuotes() -> Promise<[Quote]>
}

struct RemoteQuotesService: QuotesService {
    let networkService: NetworkService

    func fetchQuotes() -> Promise<[Quote]> {
        return networkService.fetchJson(url)
            .then(execute: jsonToQuotes)
    }
}
