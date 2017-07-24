import Foundation

struct Quote {
    let id: Int
    let text: String
    let author: String
    var isFavorite: Bool

    init(id: Int, text: String, author: String, isFavorite: Bool = false) {
        self.id = id
        self.text = text
        self.author = author
        self.isFavorite = isFavorite
    }
}

extension Quote: Equatable {}
func ==(lhs: Quote, rhs: Quote) -> Bool {
    return lhs.id == rhs.id
}
