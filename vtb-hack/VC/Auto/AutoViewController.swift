//
//  AutoViewController.swift
//  vtb-hack
//
//  Created by Semyon on 10.10.2020.
//

import UIKit
import Cartography
import IQKeyboardManagerSwift

class CreditInfo {
    
    var commnets: String = ""
    
    var firstName: String?
    var familyName: String?
    var middleName: String?
    
    var email: String?
    var incomeAmount: Int = 140000
    
    var birthDateTime: String = "1981-11-01"
    var birthDatePlace: String = "Калуга"
    var gender: String = "2"
    
    var nationalityCountryCode = "RU"
    var phone: String?
    
    var dateTime: String = convertToString(from: Date())
    var interestRate: Double = 9.9
    
    var requestedAmount: Int?
    var requestedTerm: Int?
    var tradeMark: String?
    var vehicleCost: Int?
    
    private static func convertToString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.string(from: date)
    }
    
}

class AutoViewController: UIViewController {
    
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
    
    private let fioTextField = PlaceholderView() ~> {
        $0.setup(title: "ФИО", placeholderText: "")
    }
    
    private let phoneTextField = PlaceholderView() ~> {
        $0.setup(title: "Телефон", placeholderText: "", keyboardType: .phonePad)
    }
    
    private let mailTextField = PlaceholderView() ~> {
        $0.setup(title: "Почта", placeholderText: "example@mail.ru", keyboardType: .emailAddress)
    }
    
    private let moneySlider = SliderView() ~> {
        $0.setup(title: "Сумма", initValue: 100_000, minValue: 100_000, maxValue: 1_000_000)
    }
    
    private let termSlider = SliderView() ~> {
        $0.setup(title: "Cрок кредита", initValue: 60, minValue: 12, maxValue: 360)
    }
    
    private let creditButton = CustomButton() ~> {
        $0.setTitle("Оформить заявку", for: .normal)
        $0.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    // Properties
    var creditInfo = CreditInfo()
//    var carInfo = MockCar() {

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
        
        
        creditStack.addArrangedSubview(fioTextField)
        creditStack.addArrangedSubview(phoneTextField)
        creditStack.addArrangedSubview(mailTextField)
        creditStack.addArrangedSubview(moneySlider)
        creditStack.addArrangedSubview(termSlider)
        
        constrain(creditButton) {
            $0.height == 50
        }
        footerStack.addArrangedSubview(creditButton)
    }
    
    @objc
    func buttonAction(sender: UIButton!) {
        
        //Car
        creditInfo.tradeMark = "" //Вставить марку авто
        creditInfo.vehicleCost = 1_000_000 //Вставить цену авто
        
        // FIO
        if let fioString = fioTextField.text, fioString.isEmpty == false {
            let fio = fioString.components(separatedBy: " ")
            if fio.count == 3 {
                creditInfo.firstName = fio[0]
                creditInfo.familyName = fio[1]
                creditInfo.middleName = fio[2]
            } else {
                showAlert(title: "Ошибка", message: "Введите корректное ФИО")
                return
            }
            
        } else {
            showAlert(title: "Ошибка", message: "Введите ФИО")
            return
        }
        
        // email
        if let email = mailTextField.text, email.isEmpty == false {
            creditInfo.email = email
        } else {
            showAlert(title: "Ошибка", message: "Введите почту")
            return
        }
        
        // phone
        if let phone = phoneTextField.text, phone.isEmpty == false {
            creditInfo.phone = phone
        } else {
            showAlert(title: "Ошибка", message: "Введите номер телефона")
            return
        }
        
        creditInfo.requestedAmount = Int(moneySlider.value ?? 0)
        creditInfo.requestedTerm = Int(termSlider.value ?? 0)
        
        // И тут отправить запрос
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(
                            title: "OK", style: .default, handler: { action in
                                switch action.style{
                                case .default:
                                    print("default")
                                    
                                case .cancel:
                                    print("cancel")
                                    
                                case .destructive:
                                    print("destructive")
                                    
                                    
                                }}))
        self.present(alert, animated: true, completion: nil)
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
