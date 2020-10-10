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
                    .setFailureType(to: VTBProxyResponseError.self)
                    .flatMap(RecognitionService.recognize(image:))
                    .map(Optional.init)
                    .catch { _ -> AnyPublisher<RecognizeResponse?, Never> in
                        return Just(nil).eraseToAnyPublisher()
                    }
            }
            .share()

        // should have interactor here

        recognizedImage
            .map { (response) -> String in
                guard let response = response else {
                    return "Что-то пошло не так"
                }

                let wellRecognized = response.probabilities
                    .filter { $0.value > 0.25 }
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
                    .filter { $0.value > 0.25 }
                    .sorted(by: { $0.value > $1.value })
                    .first?.key
            }
            .compactMap { $0 }
            .flatMap { (query) -> AnyPublisher<GroupedOffersResponse?, Never> in
                Just(query)
                    .setFailureType(to: Error.self)
                    .flatMap(QueryResolver.resolve(_:))
                    .flatMap { (resolvedQuery: ResolveQueryResponse) in
                        return SearchService.groupedOffers(by: resolvedQuery.suggests[0])
                    }
                    .map { (groupedOffers: GroupedOffersResponse) -> GroupedOffersResponse? in
                        return groupedOffers.offers?.isEmpty == false ? groupedOffers : nil
                    }
                    .catch { (error) -> AnyPublisher<GroupedOffersResponse?, Never> in
                        assertionFailure(error.localizedDescription)
                        return Just(nil)
                            .eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
            }
            .compactMap { $0 }
            .flatMap { (groupedOffers: GroupedOffersResponse) -> AnyPublisher<[ListingOffersResponse], Never> in
                Just(groupedOffers)
                    .setFailureType(to: Error.self)
                    .flatMap { (groupedOffers: GroupedOffersResponse) -> AnyPublisher<[ListingOffersResponse], Error> in
                        if let offers = groupedOffers.offers {
                            let publishers = offers.map { (grouped: GroupedOffersResponse.Offer) in
                                return SearchService.offers(by: grouped)
                            }

                            return Publishers.MergeMany(publishers)
                                .collect()
                                .eraseToAnyPublisher()
                        } else {
                            return Just([ListingOffersResponse]())
                                .setFailureType(to: Error.self)
                                .eraseToAnyPublisher()
                        }
                    }
                    .catch { (error) -> AnyPublisher<[ListingOffersResponse], Never> in
                        assertionFailure(error.localizedDescription)
                        return Just([]).eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
            }
            .filter { !$0.isEmpty }
            .first()
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] mergedListings in
                let offers = mergedListings
                    .compactMap { $0.offers}
                    .flatMap { $0 }

                let tinderVC = router.createTinderVC(offers: offers)
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
