import Foundation
import PromiseKit

protocol NetworkService {
    func fetchJson(_ url: String) -> Promise<Any>
}

struct AppNetworkService: NetworkService {
    func fetchJson(_ url: String) -> Promise<Any> {
        return Alamofire.request(url)
            .responseJSON()
    }
}
