//
//  AutoViewController.swift
//  vtb-hack
//
//  Created by Semyon on 10.10.2020.
//

import Cartography
import Combine
import IQKeyboardManagerSwift
import UIKit

private extension Date {
    var vtb_string: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.string(from: self)
    }
}

final class AutoViewController: UIViewController {
    private let scrollView = UIScrollView() ~> {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let backView = UIView() ~> {
        $0.backgroundColor = .clear
    }

    private let carStack = UIStackView() ~> {
        $0.axis = .vertical
        $0.spacing = 10
    }

    private let creditStack = UIStackView() ~> {
        $0.axis = .vertical
        $0.spacing = 10
    }

    private let footerStack = UIStackView() ~> {
        $0.axis = .vertical
        $0.spacing = 10
    }

    private let carImageView = UIImageView() ~> {
        $0.image = UIImage(named: "michelle")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    private let titleLabel = TSLabel() ~> {
        $0.textStyle = TextStyle.subtitle1.withColor(Color.VTB.gray90.dynamicForDark(Color.VTB.ColdGray.white))
        $0.text = "Test"
    }

    private let priceLabel = TSLabel() ~> {
        $0.textStyle = TextStyle.subtitle1.withColor(Color.VTB.gray90.dynamicForDark(Color.VTB.ColdGray.white))
        $0.text = "Test"
    }

    private let fioTextField = PlaceholderView() ~> {
        $0.setup(title: "ФИО", placeholderText: "", keyboardType: .namePhonePad, textContentType: .givenName)
    }

    private let phoneTextField = PlaceholderView() ~> {
        $0.setup(title: "Телефон", placeholderText: "", keyboardType: .phonePad, textContentType: .telephoneNumber)
    }

    private let mailTextField = PlaceholderView() ~> {
        $0.setup(title: "Почта", placeholderText: "example@mail.ru", keyboardType: .emailAddress, textContentType: .emailAddress)
    }

    private let moneySlider = SliderView() ~> {
        $0.setup(title: "Сумма", initValue: 100_000, minValue: 100_000, maxValue: 1_000_000)
    }

    private let termSlider = SliderView() ~> {
        $0.setup(title: "Cрок кредита", initValue: 30, minValue: 12, maxValue: 60)
    }

    private let creditButton = CustomButton() ~> {
        $0.setTitle("Оформить заявку", for: .normal)
        $0.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    private var bag = Set<AnyCancellable>()

    // Properties
    var carModel: ListingOffersResponse.Offer?
    var viewModel: TinderCardModel?

    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboard()
    }

    private func setupUI() {
        title = "Подробная информация"
        view.backgroundColor = Color.primary

        view.addSubview(scrollView)
        constrain(scrollView) {
            $0.leading == $0.superview!.leading
            $0.trailing == $0.superview!.trailing
            $0.top == $0.superview!.topMargin
            $0.bottom == $0.superview!.bottomMargin
            $0.width == UIScreen.width
        }

        scrollView.addSubview(backView)
        constrain(backView) {
            $0.leading == $0.superview!.leading
            $0.trailing == $0.superview!.trailing
            $0.top == $0.superview!.top
            $0.bottom == $0.superview!.bottom
            $0.width == UIScreen.width
        }

        backView.addSubview(carStack)
        constrain(carStack) {
            $0.leading == $0.superview!.leading + 16
            $0.trailing == $0.superview!.trailing - 16
            $0.top == $0.superview!.top + 10
        }

        backView.addSubview(creditStack)
        constrain(creditStack, carStack) {
            $0.leading == $0.superview!.leading
            $0.trailing == $0.superview!.trailing
            $0.top == $1.bottom + 10
        }

        backView.addSubview(footerStack)
        constrain(footerStack, creditStack) {
            $0.leading == $0.superview!.leading + 16
            $0.trailing == $0.superview!.trailing - 16
            $0.top == $1.bottom + 10
            $0.bottom == $0.superview!.bottom - 50
        }

        constrain(carImageView) {
            $0.height == 200
        }

        carStack.addArrangedSubview(carImageView)
        carStack.addArrangedSubview(titleLabel)
        carStack.addArrangedSubview(priceLabel)

        creditStack.addArrangedSubview(fioTextField)
        creditStack.addArrangedSubview(phoneTextField)
        creditStack.addArrangedSubview(mailTextField)
        creditStack.addArrangedSubview(moneySlider)
        creditStack.addArrangedSubview(termSlider)

        constrain(creditButton) {
            $0.height == 50
        }
        footerStack.addArrangedSubview(creditButton)

        titleLabel.text = (viewModel?.name ?? "") + ", " + String(viewModel?.age ?? 0)
        priceLabel.text = viewModel?.occupationWithFormat
        moneySlider.setup(title: "Сумма", initValue: 100_000, minValue: 100_000, maxValue: viewModel?.occupation ?? 1_000_000)
        if let url = viewModel?.imageUrls.last {
            carImageView.kf.setImage(
                with: URL(string: "https:\(url)"),
                placeholder: UIImage(named: "michelle")
            )
        } else {
            carImageView.image = UIImage(named: "michelle")
        }
    }

    @objc
    func buttonAction(sender: UIButton!) {
        guard
            let carInfo = carModel,
            let viewModel = viewModel
        else {
            return
        }

        // Car
//        creditInfo.tradeMark = "" // Вставить марку авто
//        creditInfo.vehicleCost = 1_000_000 // Вставить цену авто

        // FIO
        guard
            let fioString = fioTextField.text?.nilIfDefault,
            fioString.components(separatedBy: " ").count == 3
        else {
            showAlert(title: "Ошибка", message: "Введите корректное ФИО")
            return
        }

        let lastName: String
        let firstName: String
        let middleName: String

        do {
            let fioComponents = fioString.components(separatedBy: " ")
            lastName = fioComponents[0]
            firstName = fioComponents[1]
            middleName = fioComponents[2]
        }

        guard let email = mailTextField.text, !email.isEmpty else {
            showAlert(title: "Ошибка", message: "Введите почту")
            return
        }

        guard let phone = phoneTextField.text, !phone.isEmpty else {
            showAlert(title: "Ошибка", message: "Введите номер телефона")
            return
        }

        let creditInfo = CarloanRequest(
            comment: "",
            customerParty: CarloanRequest.CustomerParty(
                email: email,
                incomeAmount: 140_000, // TODO:
                person: CarloanRequest.Person(
                    birthDateTime: "1981-11-01",
                    birthPlace: "Калуга",
                    familyName: lastName,
                    firstName: firstName,
                    gender: "male",
                    middleName: middleName,
                    nationalityCountryCode: "RU"
                ),
                phone: phone
            ),
            datetime: Date().vtb_string,
            interestRate: 7, // TODO: get interest rate first
            requestedAmount: Int(moneySlider.value ?? 0),
            requestedTerm: Int(termSlider.value ?? 0),
            tradeMark: carInfo.carInfo!.mark!,
            vehicleCost: carInfo.price
        )

        let req: AnyPublisher<CarloanResponse, VTBProxyResponseError> =
            VTBProxy.post(url: URL(string: "https://gw.hackathon.vtb.ru/vtb/hackathon/carloan")!, model: creditInfo)

        req.receive(on: DispatchQueue.main)
            .sink { completion in
            switch completion {
            case let .failure(e):
                assertionFailure(e.localizedDescription)
                self.showAlert(title: "Ошибка", message: e.localizedDescription)
            case .finished:
                self.showAlert(title: "Отлично", message: "Заявка успешно создана!")
                break
            }
        } receiveValue: { response in
            print("got credit resp", response)
        }
        .store(in: &bag)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: { _ in

            })
        )
        present(alert, animated: true, completion: nil)
    }
}

extension AutoViewController {
    private func setupKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 40
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}

extension String: DefaultValueNullable {
    var nilIfDefault: String? {
        return isEmpty ? nil : self
    }
}
