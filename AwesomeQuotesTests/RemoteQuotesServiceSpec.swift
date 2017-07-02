import Quick
import Nimble
import PromiseKit

class RemoteQuotesServiceSpec: QuickSpec {
    override func spec() {
        describe("getQuotes") {

            it("returns an array of quotes") {
                let quotes = remoteSetOfQuotes()
                let quotesService = RemoteQuotesService(networkService: TestNetworkService(json: quotes.toJson()))

                var result: [Quote] = []
                quotesService.getQuotes()
                    .then { result = $0 }
                    .catch { _ in fail("getQuotes was not supposed to throw an error") }

                expect(result).toEventually(equal(quotes), timeout: 1)
            }
        }
    }
}

struct TestNetworkService: NetworkService {
    let json: Any
    func fetchJson(_ url: String) -> Promise<Any> {
        return Promise.init(value: json)
    }
}
