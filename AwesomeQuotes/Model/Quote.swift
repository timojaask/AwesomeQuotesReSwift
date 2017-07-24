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

extension Quote: Equatable {}
func ==(lhs: Quote, rhs: Quote) -> Bool {
    return
        lhs.author == rhs.author &&
        lhs.isFavorite == rhs.isFavorite &&
        lhs.text == rhs.text
}
