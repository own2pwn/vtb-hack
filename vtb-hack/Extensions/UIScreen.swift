//
//  UIScreen.swift
//  vtb-hack
//
//  Created by Semyon on 09.10.2020.
//

import Foundation
import UIKit

/// [The Ultimate Guide To iPhone Resolutions](https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions)
public extension UIScreen {

    enum DeviceFamily {
        case elevenFamily
        case xFamily
        case plusFamily
        case sixFamily
        case fifthFamily
    }

    static var deviceFamily: DeviceFamily {
        switch UIScreen.height {
        case 568:
            return .fifthFamily

        case 667:
            return .sixFamily

        case 736:
            return .plusFamily

        case 812:
            return .xFamily

        case 896:
            return .elevenFamily

        default:
            return .elevenFamily
        }
    }

    static let is320WidthScreen = UIScreen.width == 320

    static let is6DeviceFamily = UIScreen.height > 568 && UIScreen.height < 736

    static let width = UIScreen.main.bounds.width

    static let height = UIScreen.main.bounds.height

    /// iPhone X, XR, 11, Max
    static var isXDeviceFamily: Bool {
        return UIScreen.height >= 812
    }

    /// iPhone Plus, Max, XR, 11
    static var isPlusOrMaxDeviceFamily: Bool {
        return UIScreen.width >= 414 && UIScreen.main.scale == 3
    }

    var iPhoneX: Bool { UIScreen.main.nativeBounds.height == 2436 }
    var iPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
    var iPad: Bool { UIDevice().userInterfaceIdiom == .pad }

}
