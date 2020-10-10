//
//  NSAttributedString.swift
//  vtb-hack
//
//  Created by Semyon on 09.10.2020.
//

import UIKit

extension NSAttributedString {
    
    public func size(withConstrained width: CGFloat) -> CGSize {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        return boundingRect(
            with: constraintRect,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        ).integral.size
    }
    
    public func size(withConstrainedHeight height: CGFloat) -> CGSize {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        return boundingRect(
            with: constraintRect,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        ).integral.size
    }
    
}


