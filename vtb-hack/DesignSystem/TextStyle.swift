//
//  TextStyle.swift
//  vtb-hack
//
//  Created by Semyon on 09.10.2020.
//

import UIKit

public class TextStyle: NSObject {
    
    public let attributes: [NSAttributedString.Key: Any]
    public let layoutAttributes: [NSAttributedString.Key: Any]
    public let lineHeight: CGFloat
    
    public init(attributes: [NSAttributedString.Key: Any], layoutAttributes: [NSAttributedString.Key: Any], lineHeight: CGFloat) {
        self.attributes = attributes
        self.lineHeight = lineHeight
        self.layoutAttributes = layoutAttributes
    }
    
    public func textStyle(withAdditionalAttributes attributes: [NSAttributedString.Key: Any]) -> TextStyle {
        let resultAttributes = self.attributes.merging(attributes) { $1 }
        let resultLayoutAttributes = self.layoutAttributes.merging(attributes) { $1 }
        return TextStyle(attributes: resultAttributes,
                         layoutAttributes: resultLayoutAttributes,
                         lineHeight: lineHeight)
    }
    
    public func attributedString(withText text: String) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    public func withColor(_ textColor: UIColor) -> TextStyle {
        var attributes = self.attributes
        attributes[NSAttributedString.Key.foregroundColor] = textColor

        var layoutAttributes = self.layoutAttributes
        layoutAttributes[NSAttributedString.Key.foregroundColor] = textColor
        
        return TextStyle(attributes: attributes, layoutAttributes: layoutAttributes, lineHeight: lineHeight)
    }

    public func withTextAlignment(_ alignment: NSTextAlignment) -> TextStyle {
        var attributes = self.attributes
        var layoutAttributes = self.layoutAttributes
        
        func patchAttributes(_ attributes: inout [NSAttributedString.Key: Any]) {
            let paragraphStyle: NSMutableParagraphStyle
            if let existingStyle = attributes[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle,
                let mutableCopy = existingStyle.mutableCopy() as? NSMutableParagraphStyle
            {
                paragraphStyle = mutableCopy
            } else {
                paragraphStyle = NSMutableParagraphStyle()
            }
            
            paragraphStyle.alignment = alignment
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        
        patchAttributes(&attributes)
        patchAttributes(&layoutAttributes)
        
        return TextStyle(attributes: attributes, layoutAttributes: layoutAttributes, lineHeight: lineHeight)
    }
    
}

public extension TextStyle {
    
    static let lt1 = textStyle(font: Font.lt1, textColor: Color.vtbText, lineHeight: 40)
    static let lt2 = textStyle(font: Font.lt2, textColor: Color.vtbText, lineHeight: 32)
    
    static let title1 = textStyle(font: Font.title1, textColor: Color.vtbText, lineHeight: 28)
    static let title2 = textStyle(font: Font.title2, textColor: Color.vtbText, lineHeight: 28)
    
    static let subtitle1 = textStyle(font: Font.subtitle1, textColor: Color.vtbText, lineHeight: 24)
    static let subtitle2 = textStyle(font: Font.subtitle2, textColor: Color.vtbText, lineHeight: 20)
    static let subtitle3 = textStyle(font: Font.subtitle3, textColor: Color.vtbText, lineHeight: 20)
    
    static let headline = textStyle(font: Font.headline, textColor: Color.vtbText, lineHeight: 20)
    static let body1 = textStyle(font: Font.body1, textColor: Color.vtbText, lineHeight: 20)
    static let body2 = textStyle(font: Font.body2, textColor: Color.vtbText, lineHeight: 20)
    
    static let subhead1 = textStyle(font: Font.subhead1, textColor: Color.vtbText, lineHeight: 16)
    static let subhead2 = textStyle(font: Font.subhead2, textColor: Color.vtbText, lineHeight: 16)
    static let subhead3 = textStyle(font: Font.subhead3, textColor: Color.vtbText, lineHeight: 16)
    static let subhead4 = textStyle(font: Font.subhead4, textColor: Color.vtbText, lineHeight: 20)
    
    static let caption1 = textStyle(font: Font.caption1, textColor: Color.vtbText, lineHeight: 16)
    static let caption2 = textStyle(font: Font.caption2, textColor: Color.vtbText, lineHeight: 12)
    
    static let h1 = textStyle(font: Font.h1, textColor: Color.primary, lineHeight: 34)
    static let h2 = textStyle(font: Font.h2, textColor: Color.primary, lineHeight: 30)
    static let h3 = textStyle(font: Font.h3, textColor: Color.primary, lineHeight: 24)
    static let h4 = textStyle(font: Font.h4, textColor: Color.primary, lineHeight: 20)

    static let subtitleLarge = textStyle(font: Font.subtitleLarge, textColor: Color.primary, lineHeight: 18)
    static let subtitle = textStyle(font: Font.subtitle, textColor: Color.primary, lineHeight: 18)
    static let body = textStyle(font: Font.body, textColor: Color.primary, lineHeight: 22)
    static let caption = textStyle(font: Font.caption, textColor: Color.secondary, lineHeight: 16)
    static let error = textStyle(font: Font.caption, textColor: Color.softRed, lineHeight: 16)

    private static func textStyle(font: UIFont, textColor: UIColor, lineHeight: CGFloat) -> TextStyle {
        func createAttributes(isLayoutAttributes: Bool) -> [NSAttributedString.Key: Any] {
            return [
                NSAttributedString.Key.paragraphStyle: NSMutableParagraphStyle() ~> {
                    let dif = lineHeight - font.pointSize
                    $0.minimumLineHeight = font.pointSize + dif / 2
                    $0.lineSpacing = dif / 2
                    /// It's necessary because with '.byTruncatingTail' boundingRect can't calculate sizes for multiple text rows
                    $0.lineBreakMode = isLayoutAttributes ? .byWordWrapping : .byTruncatingTail
                },
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: textColor
            ]
        }
        let attributes = createAttributes(isLayoutAttributes: false)
        let layoutAttributes = createAttributes(isLayoutAttributes: true)
        return TextStyle(attributes: attributes, layoutAttributes: layoutAttributes, lineHeight: lineHeight)
    }
}
