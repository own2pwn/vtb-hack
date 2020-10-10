//
//  PlaceholderView.swift
//  vtb-hack
//
//  Created by Semyon on 10.10.2020.
//

import UIKit
import Cartography

class PlaceholderView: UIView {
    
    enum Spec {
        static let titleStyle = TextStyle.subhead3
    }
    
    private let titleLabel = TSLabel() ~> {
        $0.textStyle = Spec.titleStyle.withColor(Color.VTB.ColdGray.coldGray40)
    }
    
    private let textField = UITextField() ~> {
        $0.placeholder = "Введите текст"
        
    }
    
    private let bottomLine = UIView() ~> {
        $0.backgroundColor = Color.VTB.ColdGray.coldGray40
    }
    
    // MARK: Public
    
    var text: String? {
        return textField.text
    }
    
    func setup(title: String?, placeholderText: String?, keyboardType: UIKeyboardType = .default) {
        titleLabel.text = title
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText ?? "",
            attributes: [
                NSAttributedString.Key.foregroundColor: Color.VTB.ColdGray.coldGray20,
                NSAttributedString.Key.font: Font.body1
            ])
        textField.tintColor = .green
        textField.keyboardType = keyboardType
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(titleLabel)
        constrain(titleLabel) {
            $0.leading == $0.superview!.leading + 16
            $0.trailing == $0.superview!.trailing - 16
            $0.top == $0.superview!.top + 16
            $0.height == Spec.titleStyle.lineHeight
        }
        
        addSubview(textField)
        constrain(textField, titleLabel) {
            $0.leading == $0.superview!.leading + 16
            $0.trailing == $0.superview!.trailing - 16
            $0.top == $1.bottom + 8
        }
        
        addSubview(bottomLine)
        constrain(bottomLine) {
            $0.leading == $0.superview!.leading + 16
            $0.trailing == $0.superview!.trailing - 16
            $0.bottom == $0.superview!.bottom - 7
            $0.height == 1 
        }
        
        constrain(self) {
            $0.height == 72
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.frame.width, height: 72)
    }
    
}

