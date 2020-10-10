import Combine
import Foundation

enum VTBProxyResponseError: Error {
    case non200
    case boxed(Error)
}

enum VTBProxy {
    static let basicHeaders: [String: String] = [
        "x-ibm-client-id": "78985970044dd4db2506956b45328c75",
        "accept": "application/json",
        "content-type": "application/json"
    ]

    static let session: URLSession = {
        let sessionConfig = URLSessionConfiguration.ephemeral
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        sessionConfig.httpAdditionalHeaders = basicHeaders
        return URLSession(configuration: sessionConfig)
    }()

    private static let encoder: JSONEncoder = {
        let enc = JSONEncoder()
        enc.dataEncodingStrategy = JSONEncoder.DataEncodingStrategy.base64
        return enc
    }()

    private static let decoder: JSONDecoder = {
        let dec = JSONDecoder()
        dec.nonConformingFloatDecodingStrategy = .throw
        return dec
    }()

    static func get<T: Decodable>(url: URL) -> AnyPublisher<T, VTBProxyResponseError> {
        let request = URLRequest(url: url)

        return Self.session.dataTaskPublisher(for: request)
            .tryMap { (data: Data, response: URLResponse) -> T in
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    throw VTBProxyResponseError.non200
                }

                return try decoder.decode(T.self, from: data)
            }
            .mapError { e in
                return VTBProxyResponseError.boxed(e)
            }
            .eraseToAnyPublisher()
    }

    static func post<M: Encodable, R: Decodable>(url: URL, model: M) -> AnyPublisher<R, VTBProxyResponseError> {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! Self.encoder.encode(model)

        return Self.session.dataTaskPublisher(for: request)
            .tryMap { (data: Data, response: URLResponse) -> R in
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    throw VTBProxyResponseError.non200
                }

                return try decoder.decode(R.self, from: data)
            }
            .mapError { e in
                return VTBProxyResponseError.boxed(e)
            }
            .eraseToAnyPublisher()
    }
}
