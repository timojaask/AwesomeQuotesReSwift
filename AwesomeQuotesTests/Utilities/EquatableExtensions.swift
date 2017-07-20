import Foundation
@testable import AwesomeQuotes

extension AppState: Equatable {}
public func ==(lhs: AppState, rhs: AppState) -> Bool {
    return
        lhs.currentQuoteIndex == rhs.currentQuoteIndex &&
            lhs.fetchQuotesState == rhs.fetchQuotesState &&
            lhs.quotes == rhs.quotes

}

extension Quote: Equatable {}
public func ==(lhs: Quote, rhs: Quote) -> Bool {
    return
        lhs.author == rhs.author &&
            lhs.isFavorite == rhs.isFavorite &&
            lhs.text == rhs.text
}

extension FetchQuotesState: Equatable { }
public func ==(lhs: FetchQuotesState, rhs: FetchQuotesState) -> Bool {
    switch (lhs, rhs) {
    case (.none, .none):
        return true
    case (.request, .request):
        return true
    case let (.success(lhsVal), .success(rhsVal)):
        return lhsVal == rhsVal
    case let (.error(lhsVal), .error(rhsVal)):
        return lhsVal == rhsVal
    default:
        return false
    }
}

extension FetchQuotes: Equatable {}
public func ==(lhs: FetchQuotes, rhs: FetchQuotes) -> Bool {
    return lhs.state == rhs.state
}

extension Error where Self: Equatable {}
func ==(lhs: Error, rhs: Error) -> Bool {
    return lhs.localizedDescription == rhs.localizedDescription &&
        lhs.isCancelledError == rhs.isCancelledError
}


