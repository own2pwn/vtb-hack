//
//  TSLabel.swift
//  vtb-hack
//
//  Created by Semyon on 09.10.2020.
//

import UIKit

public class TSLabel: UILabel {

    public var textStyle: TextStyle? {
        didSet {
            if let tsText = tsText {
                super.attributedText = NSAttributedString(string: tsText, attributes: textStyle?.attributes)
            }
        }
    }

    private var tsText: String?
    public override var text: String? {
        get {
            return tsText
        }
        set {
            // It's need for keyPath observing (e.g. ReactiveCocoa keyPath observing)
            willChangeValue(for: \.text)
            defer {
                didChangeValue(for: \.text)
            }

            tsText = newValue
            guard let newValue = newValue else {
                super.attributedText = nil
                return
            }
            super.attributedText = NSAttributedString(string: newValue, attributes: textStyle?.attributes)
        }
    }

}

// MARK: - Interface methods
extension TSLabel {

    public func changeAttributedTextColor(to color: UIColor) {
        textStyle = textStyle?.withColor(color)
    }

}
