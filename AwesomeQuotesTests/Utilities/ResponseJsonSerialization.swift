import Foundation
@testable import AwesomeQuotes

extension Array where Element == Quote {
    func toJson() -> [[String:Any]] {
        return self.map { $0.toJson() }
    }
}

extension Quote {
    func toJson() -> [String: Any] {
        return [ "id": id, "text": text, "author": author ]
    }
}
