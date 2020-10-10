import Combine
import Foundation

enum Backend {
    private static let encoder: JSONEncoder = {
        let e = JSONEncoder()
        e.dataEncodingStrategy = .base64
        return e
    }()

    private static let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }()

    private static let session: URLSession = {
        let sessionConfig = URLSessionConfiguration.ephemeral
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData

        sessionConfig.connectionProxyDictionary = {
            return [:]
//            return [
//                kCFNetworkProxiesHTTPEnable as String: 1,
//                kCFNetworkProxiesHTTPProxy as String: "192.168.88.245",
//                kCFNetworkProxiesHTTPPort as String: 8888,
//                kCFStreamPropertyHTTPSProxyHost as String: "192.168.88.245",
//                kCFStreamPropertyHTTPSProxyPort as String: 8888
//            ]
        }()

        return URLSession(configuration: sessionConfig)
    }()

    static func get<T: Decodable>(endpoint: String) -> AnyPublisher<T, Error> {
        let req = URLRequest(url: URL(string: "https://uptest.3xpl017.cc/api/vtb/\(endpoint)")!)

        return session.dataTaskPublisher(for: req)
            .tryMap { (data: Data, _: URLResponse) -> T in
                let boxedResponse = try! decoder.decode(BackendResponse.self, from: data)
                do {
                    return try decoder.decode(T.self, from: boxedResponse.content)
                } catch {
                    (error as? DecodingError).flatMap { e in
                        print(e.errorDescription, e.failureReason, e.localizedDescription)
                    }
                    assertionFailure(error.localizedDescription)
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }

    static func post<M, R>(endpoint: String, body: M) -> AnyPublisher<R, Error> where M: Encodable, R: Decodable {
        var req = URLRequest(url: URL(string: "https://uptest.3xpl017.cc/api/vtb/\(endpoint)")!)
        req.httpMethod = "POST"
        req.httpBody = try! encoder.encode(body)

        return session.dataTaskPublisher(for: req)
            .tryMap { (data: Data, _: URLResponse) -> R in
                let boxedResponse = try! decoder.decode(BackendResponse.self, from: data)
                return try decoder.decode(R.self, from: boxedResponse.content)
            }
            .eraseToAnyPublisher()
    }
}

struct BackendResponse: Decodable {
    let content: Data
}
