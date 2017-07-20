import PromiseKit

class AppStateCodable: NSObject, NSCoding {
    let quotes: [Quote]
    let currentQuoteIndex: Int

    convenience init(appState: AppState) {
        self.init(quotes: appState.quotes, currentQuoteIndex: appState.currentQuoteIndex)
    }

    init(quotes: [Quote], currentQuoteIndex: Int) {
        self.quotes = quotes
        self.currentQuoteIndex = currentQuoteIndex
    }

    required convenience init?(coder decoder: NSCoder) {
        guard let quotesCodable = decoder.decodeObject(forKey: "quotes") as? [QuoteCodable]
            else { return nil }
        let currentQuoteIndex = decoder.decodeInteger(forKey: "currentQuoteIndex")
        let quotes = quotesCodable.map { $0.toQuote() }

        self.init(quotes: quotes, currentQuoteIndex: currentQuoteIndex)
    }

    func encode(with coder: NSCoder) {
        let quotesCodable = quotes.map(QuoteCodable.init)
        coder.encode(quotesCodable, forKey: "quotes")
        coder.encode(self.currentQuoteIndex, forKey: "currentQuoteIndex")
    }

    func toAppState() -> AppState {
        return AppState(quotes: self.quotes, currentQuoteIndex: self.currentQuoteIndex)
    }
}

class QuoteCodable: NSObject, NSCoding {
    let text: String
    let author: String
    var isFavorite: Bool

    convenience init(quote: Quote) {
        self.init(text: quote.text, author: quote.author, isFavorite: quote.isFavorite)
    }

    init(text: String, author: String, isFavorite: Bool) {
        self.text = text
        self.author = author
        self.isFavorite = isFavorite
    }

    required convenience init?(coder decoder: NSCoder) {
        guard let text = decoder.decodeObject(forKey: "text") as? String,
            let author = decoder.decodeObject(forKey: "author") as? String
            else { return nil }
        let isFavorite = decoder.decodeBool(forKey: "isFavorite")

        self.init(text: text, author: author, isFavorite: isFavorite)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.text, forKey: "text")
        coder.encode(self.author, forKey: "author")
        coder.encode(self.isFavorite, forKey: "isFavorite")
    }

    func toQuote() -> Quote {
        return Quote(text: text, author: author, isFavorite: isFavorite)
    }
}

struct FileStorage: LocalStorage {

    let fileName: String

    static func filePath(_ fileName: String) -> String {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url!.appendingPathComponent(fileName).path)
    }

    func saveState(state: AppState) -> Promise<Void> {
        let codable = AppStateCodable(appState: state)
        NSKeyedArchiver.archiveRootObject(codable, toFile: FileStorage.filePath(self.fileName))

        return Promise.init { (fulfill, reject) in
            fulfill()
        }
    }

    func loadState() -> Promise<AppState> {
        return Promise.init { (fulfill, reject) in
            guard let codable = NSKeyedUnarchiver.unarchiveObject(withFile: FileStorage.filePath(self.fileName)) as? AppStateCodable else {
                fulfill(AppState())
                return
            }
            fulfill(codable.toAppState())
        }
    }
    
}
