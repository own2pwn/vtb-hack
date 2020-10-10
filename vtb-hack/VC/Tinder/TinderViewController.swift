import PopBounceButton
import Shuffle_iOS

typealias LikedCar = (model: ListingOffersResponse.Offer, viewModel: TinderCardModel)

var likedCarsModel: [LikedCar] = []

final class TinderViewController: UIViewController {
    private let cardStack = SwipeCardStack()
    private let buttonStackView = ButtonStackView()

    private let responseOffers: [ListingOffersResponse.Offer]
    private let model: [TinderCardModel]

    init(offers: [ListingOffersResponse.Offer]) {
        self.responseOffers = offers
        self.model = offers.map { (offer: ListingOffersResponse.Offer) -> TinderCardModel in
            return TinderCardModel(
                name: offer.title,
                age: offer.documents?.year?.nilIfDefault ?? offer.carInfo!.superGen!.yearFrom!,
                occupation: offer.price,
                occupationWithFormat: offer.formattedPrice,
                image: [],
                imageUrls: offer.state!.imageUrls!.map { $0.sizes!.the1200X900N! }
            )
        }
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.primary

        cardStack.delegate = self
        cardStack.dataSource = self
        buttonStackView.delegate = self

        configureNavigationBar()
        layoutButtonStackView()
        layoutCardStackView()
    }

    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: self,
            action: #selector(handleShift)
        )
        backButton.tag = 1
        backButton.tintColor = .lightGray
        navigationItem.leftBarButtonItem = backButton

        let forwardButton = UIBarButtonItem(
            title: "Forward",
            style: .plain,
            target: self,
            action: #selector(handleShift)
        )
        forwardButton.tag = 2
        forwardButton.tintColor = .lightGray
        navigationItem.rightBarButtonItem = forwardButton

        navigationController?.navigationBar.layer.zPosition = -1
    }

    private func layoutButtonStackView() {
        view.addSubview(buttonStackView)
        buttonStackView.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 24,
            paddingBottom: 12,
            paddingRight: 24
        )
    }

    private func layoutCardStackView() {
        view.addSubview(cardStack)
        cardStack.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: buttonStackView.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
    }

    @objc
    private func handleShift(_ sender: UIButton) {
        cardStack.shift(withDistance: sender.tag == 1 ? -1 : 1, animated: true)
    }
}

// MARK: Data Source + Delegates

extension TinderViewController: ButtonStackViewDelegate, SwipeCardStackDataSource, SwipeCardStackDelegate {
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let card = SwipeCard()
        card.footerHeight = 160
        card.swipeDirections = [.left, .up, .right]
        for direction in card.swipeDirections {
            card.setOverlay(TinderCardOverlay(direction: direction), forDirection: direction)
        }

        let model = self.model[index]
        card.content = TinderCardContentView(withImageUrl: model.imageUrls.first)
        card.footer = TinderCardFooterView(withTitle: "\(model.name), \(model.age)", subtitle: model.occupationWithFormat)

        return card
    }

    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return model.count
    }

    func didSwipeAllCards(_ cardStack: SwipeCardStack) {}

    func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {}

    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        if direction == .right || direction == .up {
            likedCarsModel.append(
                (responseOffers[index], model[index])
            )
        }
    }

    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        print("Card tapped")
    }

    func didTapButton(at index: Int) {
        switch index {
        case 0:
            cardStack.swipe(.left, animated: true)
        case 1:
            cardStack.swipe(.up, animated: true)
        case 2:
            cardStack.swipe(.right, animated: true)
        default:
            break
        }
    }
}
