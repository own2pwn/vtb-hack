import Combine
import UIKit

struct RecognizeRequest: Encodable {
    let content: Data
}

struct RecognizeResponse: Decodable {
    let probabilities: [String: Double]
}

enum RecognitionService {
    static func recognize(image: UIImage) -> AnyPublisher<RecognizeResponse, VTBProxyResponseError> {
        let u = URL(string: "https://gw.hackathon.vtb.ru/vtb/hackathon/car-recognize")!

        return VTBProxy.post(
            url: u,
            model: RecognizeRequest(content: image.jpegData(compressionQuality: 95).unsafelyUnwrapped)
        )
    }
}
