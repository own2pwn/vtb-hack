import Combine
import UIKit

final class ViewController: UIViewController {
    private let router = AppRouter()
    private let frameExtractor = FrameExtractor()
    private var bag = Set<AnyCancellable>()

    private let frameImageView = UIImageView()
    private let resultLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 26)
        lbl.numberOfLines = 0
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(frameImageView)
        view.addSubview(resultLabel)

        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 72),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16)
        ])

        frameImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            frameImageView.topAnchor.constraint(equalTo: view.topAnchor),
            frameImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        setupStream()
    }

    private func resolveQuery() {
        QueryResolver.resolve("BMW 3 новые")
            .flatMap { resolved in
                return SearchService.groupedOffers(by: resolved.suggests[0])
            }
            .flatMap { groupedOffers in
                return SearchService.offers(by: groupedOffers.offers[0])
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    fatalError(error.localizedDescription)
                case .finished:
                    break
                }

            }, receiveValue: { response in
                for offer in response.offers {
                    let info = "\(offer.title) - \(offer.formattedPrice)\n\(offer.state.imageUrls.count > 1)"
                    print(info)
                }
            })
            .store(in: &bag)
    }

    private func setupStream() {
        frameExtractor.imagePublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] image in
                self.frameImageView.image = image
            }
            .store(in: &bag)

        let scaledImage = frameExtractor.scaledImagePublisher
            .throttle(for: .milliseconds(1250), scheduler: DispatchQueue.global(qos: .default), latest: true)
            .share()

        let recognizedImage = scaledImage
            .flatMap { (frame: UIImage) in
                Just(frame)
                    .setFailureType(to: RecognizeResponseError.self)
                    .flatMap(RecognitionService.recognize(image:))
                    .map(Optional.init)
                    .catch { _ -> AnyPublisher<RecognizeResponse?, Never> in
                        return Just(nil).eraseToAnyPublisher()
                    }
            }
            .share()

        recognizedImage
            .map { (response) -> String in
                guard let response = response else {
                    return "Что-то пошло не так"
                }

                let wellRecognized = response.probabilities
                    .filter { $0.value > 0.15 }
                    .sorted(by: { $0.value > $1.value })

                guard !wellRecognized.isEmpty else {
                    return "Точно машина??"
                }
                let bestMatch = wellRecognized[0]
                return "Похоже на \(bestMatch.key)"
            }
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] text in
                self.resultLabel.text = text
            }
            .store(in: &bag)

        recognizedImage
            .compactMap { (response) -> String? in
                guard let response = response else {
                    return nil
                }

                return response.probabilities
                    .filter { $0.value > 0.15 }
                    .sorted(by: { $0.value > $1.value })
                    .first?.key
            }
            .compactMap { $0 }
            .flatMap { (query) -> AnyPublisher<ResolveQueryResponse?, Never> in
                Just(query)
                    .setFailureType(to: Error.self)
                    .flatMap(QueryResolver.resolve(_:))
                    .map(Optional.init)
                    .catch { (error) -> AnyPublisher<ResolveQueryResponse?, Never> in
                        assertionFailure(error.localizedDescription)
                        return Just(nil)
                            .eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
            }
            .compactMap { $0 }
            .first()
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] resolvedQuery in
                let tinderVC = router.createTinderVC(query: resolvedQuery)
                tinderVC.modalPresentationStyle = .fullScreen
                present(tinderVC, animated: true, completion: nil)
            }
            .store(in: &bag)
    }

    @objc
    private func handleGo() {}
}

// TODO: пушнуть ARKit контроллер с тачкой чтобы повертеть можно было
// Ходить в DaData
// Локализация под юзера
