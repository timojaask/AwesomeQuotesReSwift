import PromiseKit
@testable import AwesomeQuotes

enum TestQuotesServiceError: Error {
    case someError
}

struct TestQuotesService: QuotesService {
    let quotes: [Quote]
    let shouldFail: Bool
    let fetchQuotesCallback: (() -> Void)?

    init(shouldFail: Bool) {
        self.init(quotes: [], shouldFail: shouldFail, fetchQuotesCallback: nil)
    }

    init(quotes: [Quote]) {
        self.init(quotes: quotes, shouldFail: false, fetchQuotesCallback: nil)
    }

    init(fetchQuotesCallback: (() -> Void)?) {
        self.init(quotes: [], shouldFail: false, fetchQuotesCallback: fetchQuotesCallback)
    }

    init(quotes: [Quote], shouldFail: Bool, fetchQuotesCallback: (() -> Void)?) {
        self.quotes = quotes
        self.shouldFail = shouldFail
        self.fetchQuotesCallback = fetchQuotesCallback
    }

    func fetchQuotes() -> Promise<[Quote]> {
        self.fetchQuotesCallback?()
        return promise(shouldFail: self.shouldFail) { $0(self.quotes) }
    }

    private func promise<T>(shouldFail: Bool, _ fulfillCall: (_ fulfill: (T) -> Void) -> Void) -> Promise<T> {
        return Promise { (fulfill, reject) in
            guard !shouldFail else {
                reject(TestQuotesServiceError.someError)
                return
            }
            fulfillCall(fulfill)
        }
    }
}
