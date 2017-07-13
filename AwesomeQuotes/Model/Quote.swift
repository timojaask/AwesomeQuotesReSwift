import Foundation

struct Quote {
    let text: String
    let author: String
    var isFavorite: Bool

    init(text: String, author: String, isFavorite: Bool = false) {
        self.text = text
        self.author = author
        self.isFavorite = isFavorite
    }
}
