//
//  UIColor.swift
//  vtb-hack
//
//  Created by Semyon on 09.10.2020.
//

import UIKit

extension UIColor {
    
    convenience init(hex: String) {
        var hexString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public func dynamicForDark(_ darkColor: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(dynamicProvider: { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ? darkColor : self
            })
        }
        return self
    }
    
}
