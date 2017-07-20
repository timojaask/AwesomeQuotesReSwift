import Foundation
@testable import AwesomeQuotes

extension AppState: Equatable {}
public func ==(lhs: AppState, rhs: AppState) -> Bool {
    return
        lhs.currentQuoteIndex == rhs.currentQuoteIndex &&
            lhs.quotes == rhs.quotes

}

extension Quote: Equatable {}
public func ==(lhs: Quote, rhs: Quote) -> Bool {
    return
        lhs.author == rhs.author &&
            lhs.isFavorite == rhs.isFavorite &&
            lhs.text == rhs.text
}

extension Error where Self: Equatable {}
func ==(lhs: Error, rhs: Error) -> Bool {
    return lhs.localizedDescription == rhs.localizedDescription &&
        lhs.isCancelledError == rhs.isCancelledError
}


