import Foundation
@testable import AwesomeQuotes

extension Array where Element == Quote {
    func toJson() -> Any {
        return self.map { $0.toJson() }
    }
}

extension Quote {
    func toJson() -> Any {
        return [ "text": text, "author": author ]
    }
}
