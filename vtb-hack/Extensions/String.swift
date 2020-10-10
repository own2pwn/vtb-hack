//
//  String.swift
//  vtb-hack
//
//  Created by Semyon on 09.10.2020.
//

import Foundation

import UIKit

public extension String {
    
    var bool: Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label = UILabel(
            frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude)
        )
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.height
    }
    
    func height(withConstrained width: CGFloat, textStyle: TextStyle) -> CGFloat {
        return NSAttributedString(string: self, attributes: textStyle.layoutAttributes)
            .size(withConstrained: width).height
    }
    
    func width(withConstrained height: CGFloat, textStyle: TextStyle) -> CGFloat {
        return NSAttributedString(string: self, attributes: textStyle.layoutAttributes)
            .size(withConstrainedHeight: height).width
    }
    
}
