//
//  Colors.swift
//  vtb-hack
//
//  Created by Semyon on 09.10.2020.
//

import UIKit

class Color {
    
    // Univarsal
    static let softRed = UIColor(hex: "ee6055")
    
    //Day
    static let white = UIColor(hex: "FFFFFF")
    static let gray4 = UIColor(hex: "F5F5F6")
    static let gray60 = UIColor(hex: "666975")
    static let lightGray = UIColor(hex: "F2F2F2")

    //Night
    static let black = UIColor(hex: "000518")
    static let deepBlue = UIColor(hex: "141D26")
    static let darkPink = UIColor(hex: "C51F5D")
    static let darkBlue = UIColor(hex: "243447")
    static let gray60Night = UIColor(hex: "969799")
    
    //Dynmaic
    static let vtbText = Color.VTB.gray90.dynamicForDark(Color.white)
    static let primary = Color.gray4.dynamicForDark(Color.deepBlue)
    static let secondary = Color.gray60.dynamicForDark(Color.gray60Night)
    
    // UI VTB
    // https://www.figma.com/file/jWErRjWMWa5HA8zq211XeE/Admiral-Mobile-UI-Kit-(iOS)?node-id=4163%3A316
    enum VTB {
        static let gray90 = UIColor(hex: "222222")
        
        enum ColdGray {
            static let white = UIColor(hex: "FFFFFF")
            static let coldGray5 = UIColor(hex: "F0F2F5")
            static let coldGray20 = UIColor(hex: "DDDFE3")
            static let coldGray40 = UIColor(hex: "99A0AB")
            static let coldGray70 = UIColor(hex: "546173")
        }
        
        enum Blue {
            static let blue20 = UIColor(hex: "D8E6FC")
            static let blue30 = UIColor(hex: "B0CDF9")
            static let blue40 = UIColor(hex: "89B5F7")
            static let blue60 = UIColor(hex: "3A83F1")
            static let blue70 = UIColor(hex: "316FCC")
            static let blue100 = UIColor(hex: "0B1D37")
        }
        
        enum Red {
            static let red60 = UIColor(hex: "FF3B30, 100 %")
            static let red50 = UIColor(hex: "FF6259, 100 %")
            static let red30 = UIColor(hex: "FFB1AC, 100 %")
            static let red20 = UIColor(hex: "FFD8D6, 100 %")
        }
        
        enum Orange {
            static let orange60 = UIColor(hex: "FB9130")
            static let orange30 = UIColor(hex: "FFCF87")
            static let orange20 = UIColor(hex: "FFDFAF")
        }
        
        enum Green {
            static let green60 = UIColor(hex: "45BF78")
            static let green30 = UIColor(hex: "B4E5C9")
            static let green20 = UIColor(hex: "DAF2E4")
        }
        
        enum Support {
            static let yellow50 = UIColor(hex: "FFC500")
            static let greenApple50 = UIColor(hex: "CDDC3A")
            static let greenSea50 = UIColor(hex: "00AAFF")
            static let catbirdEgg50 = UIColor(hex: "00BCD4")
            static let purple50 = UIColor(hex: "3E51B5")
            static let orchid50 = UIColor(hex: "B557B0")
        }
        
    }
    
}
