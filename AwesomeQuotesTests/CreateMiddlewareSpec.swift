import Quick
import Nimble
import ReSwift
@testable import AwesomeQuotes

class CreateMiddlewareSpec: QuickSpec {

    override func spec() {
        describe("createMiddleware") {
            it("calls all middleware items when action is dispatched") {
                var middlewareItem1Called = false
                var middlewareItem2Called = false

                let middlewareItems = [
                { (action: Action, dispatch: @escaping DispatchFunction) -> Void in
                    middlewareItem1Called = true
                    },
                { (action: Action, dispatch: @escaping DispatchFunction) -> Void in
                    middlewareItem2Called = true
                    }
                ]

                self.callMiddleware(action: FetchQuotes.request, items: middlewareItems)

                expect(middlewareItem1Called).toEventually(beTrue(), timeout: 1)
                expect(middlewareItem2Called).toEventually(beTrue(), timeout: 1)
            }

            it("passes correct action to all middleware items") {
                let expectedQuotes = remoteSetOfQuotes()
                var actualQuotes1: [Quote]?
                var actualQuotes2: [Quote]?

                let middlewareItems = [
                { (action: Action, dispatch: @escaping DispatchFunction) -> Void in
                    guard let action = action as? FetchQuotes,
                        case .success(let fetchedQuotes) = action else { return }
                    actualQuotes1 = fetchedQuotes
                    },
                { (action: Action, dispatch: @escaping DispatchFunction) -> Void in
                    guard let action = action as? FetchQuotes,
                        case .success(let fetchedQuotes) = action else { return }
                    actualQuotes2 = fetchedQuotes
                    }
                ]

                let action = FetchQuotes.success(quotes: expectedQuotes)
                self.callMiddleware(action: action, items: middlewareItems)

                expect(actualQuotes1).toEventually(equal(expectedQuotes), timeout: 1)
                expect(actualQuotes2).toEventually(equal(expectedQuotes), timeout: 1)
            }

            it("passes correct dispatch function to all middleware items") {
                let expectedQuotes = remoteSetOfQuotes()
                let expectedDispatchCalls = 2
                var actualDispatchCalls = 0

                let middlewareItems = [
                { (action: Action, dispatch: @escaping DispatchFunction) -> Void in
                    dispatch(FetchQuotes.success(quotes: expectedQuotes))
                    },
                { (action: Action, dispatch: @escaping DispatchFunction) -> Void in
                    dispatch(FetchQuotes.success(quotes: expectedQuotes))
                    }
                ]

                self.callMiddleware(action: FetchQuotes.request, items: middlewareItems) { action in
                    guard let action = action as? FetchQuotes,
                        case .success(let actualQuotes) = action else { return }

                    actualDispatchCalls += 1
                    expect(actualQuotes).to(equal(expectedQuotes))
                }

                expect(actualDispatchCalls).toEventually(equal(expectedDispatchCalls))
            }
        }
    }

    func callMiddleware(action: Action, items: [MiddlewareItem], dispatchFunction: ((Action) -> Void)? = nil) {
        let middleware = createMiddleware(items: items)
        let dispatchFunction = dispatchFunction ?? { (_: Action) in }
        let getState = { () -> AppState? in AppState() }
        middleware(dispatchFunction, getState)(dispatchFunction)(action)
    }
}
