//
//  CustomButton.swift
//  vtb-hack
//
//  Created by Semyon on 10.10.2020.
//

import UIKit

final class CustomButton: UIButton {
    enum StateButton {
        case plain
        case transparent
    }

    enum Spec {
        static let backgroundColor = UIColor(red: 0.12, green: 0.58, blue: 0.97, alpha: 1.0)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit(state: .plain)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        internalInit(state: .plain)
    }

    init(state: StateButton) {
        super.init(frame: .zero)
        internalInit(state: state)
    }

    private func internalInit(state: StateButton) {
        let color = UIColor.white
        let disabledColor = color.withAlphaComponent(0.3)

        let btnFont = UIFont.systemFont(ofSize: 16, weight: .semibold)

        layer.cornerRadius = 10.0
        clipsToBounds = true

        setTitleColor(color, for: .normal)
        setTitleColor(disabledColor, for: .disabled)
        titleLabel?.font = btnFont
        titleLabel?.adjustsFontSizeToFitWidth = true
        setTitle(titleLabel?.text?.capitalized, for: .normal)

        switch state {
        case .plain:
            backgroundColor = Spec.backgroundColor
            layer.borderWidth = 0
            layer.borderColor = color.cgColor
        case .transparent:
            backgroundColor = .clear
            layer.borderWidth = 1
            layer.borderColor = Spec.backgroundColor.cgColor
        }

        setTitleColor(.gray, for: .highlighted)
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let oldSize = max(frame.width, frame.height)
        let newSize = oldSize - 8
        let newScale = newSize / oldSize
        transform = CGAffineTransform.identity.scaledBy(x: newScale, y: newScale)
        return super.beginTracking(touch, with: event)
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        UIView.animate(withDuration: UIView.inheritedAnimationDuration) {
            self.transform = .identity
        }
    }
}

