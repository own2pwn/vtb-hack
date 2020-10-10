import Combine
import UIKit

struct RecognizeRequest: Encodable {
    let content: Data
}

struct RecognizeResponse: Decodable {
    let probabilities: [String: Double]
}

enum RecognizeResponseError: Error {
    case non200
    case boxed(Error)
}

enum RecognitionService {
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

    static func recognize(image: UIImage) -> AnyPublisher<RecognizeResponse, RecognizeResponseError> {
        let session = URLSession.shared

        var request = URLRequest(url: URL(string: "https://gw.hackathon.vtb.ru/vtb/hackathon/car-recognize")!)
        request.httpBody = try! Self.encoder.encode(
            RecognizeRequest(content: image.jpegData(compressionQuality: 95).unsafelyUnwrapped)
        )
        request.httpMethod = "POST"

        request.addValue("78985970044dd4db2506956b45328c75", forHTTPHeaderField: "x-ibm-client-id")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("application/json", forHTTPHeaderField: "content-type")

        return session.dataTaskPublisher(for: request)
            .tryMap { (data: Data, response: URLResponse) -> RecognizeResponse in
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    throw RecognizeResponseError.non200
                }

                return try decoder.decode(RecognizeResponse.self, from: data)
            }
            .mapError { e in
                return RecognizeResponseError.boxed(e)
            }
            .eraseToAnyPublisher()
    }
}
