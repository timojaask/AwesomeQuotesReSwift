import Foundation
@testable import AwesomeQuotes

extension AppState: Equatable {}
public func ==(lhs: AppState, rhs: AppState) -> Bool {
    return
        lhs.currentQuoteIndex == rhs.currentQuoteIndex &&
            lhs.quotes == rhs.quotes

}

extension Error where Self: Equatable {}
func ==(lhs: Error, rhs: Error) -> Bool {
    return lhs.localizedDescription == rhs.localizedDescription &&
        lhs.isCancelledError == rhs.isCancelledError
}


