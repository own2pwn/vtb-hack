import Combine
import Foundation

enum QueryResolver {
    private static let decoder: JSONDecoder = {
        let d = JSONDecoder()
        return d
    }()

    static func resolve(_ query: String) -> AnyPublisher<ResolveQueryResponse, Error> {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return Backend.get(endpoint: "resolve-query?query=\(query)")
    }
}
