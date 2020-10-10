//
//  CarCell.swift
//  vtb-hack
//
//  Created by Semyon on 09.10.2020.
//

import UIKit
import Cartography

class CarCell: ShadowableCollectionViewCell {
    
    // Spec
    private enum Spec {
        static let titleStyle = TextStyle.subhead1
        static let subTitleStyle = TextStyle.subhead2
        
        static let horrizontalOffset: CGFloat = 15
        static let verticalOffset: CGFloat = 15
        static let textVerticalOffset: CGFloat = 5
    }
    
    // UI components
    
    private var backView = UIView() ~> {
        $0.backgroundColor = Color.secondary
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
    }
    
    private var backTextView = UIView() ~> {
        let color = Color.VTB.ColdGray.coldGray5.dynamicForDark(Color.VTB.Blue.blue100)
        $0.backgroundColor = color.withAlphaComponent(0.9)
    }
    
    private var imageView = UIImageView() ~> {
        $0.image = UIImage(named: "michelle")
        $0.contentMode = .scaleAspectFill
    }
    
    private var titleLabel = TSLabel() ~> {
        $0.textStyle = Spec.titleStyle
        $0.numberOfLines = 2
    }
    
    private var subtitleLabel = TSLabel() ~> {
        $0.textStyle = Spec.subTitleStyle
        $0.numberOfLines = 2
    }
    
    // Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String) {
        titleLabel.text = title
        subtitleLabel.text = "Test"
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        contentView.addSubview(backView)
        constrain(backView) {
            $0.edges == inset($0.superview!.edges, 0, 0, 0, 0)
        }
        
        backView.addSubview(imageView)
        constrain(imageView) {
            $0.edges == inset($0.superview!.edges, 0, 0, 0, 0)
        }
        
        imageView.addSubview(backTextView)
        constrain(backTextView) {
            $0.leading == $0.superview!.leading
            $0.trailing == $0.superview!.trailing
            $0.bottom == $0.superview!.bottom
//            $0.height == (Spec.titleStyle.lineHeight * 1) + (Spec.subTitleStyle.lineHeight * 1) + Spec.textVerticalOffset * 3
        }
        
        backTextView.addSubview(titleLabel)
        constrain(titleLabel) {
            $0.leading == $0.superview!.leading + Spec.horrizontalOffset
            $0.trailing == $0.superview!.trailing - Spec.horrizontalOffset
            $0.top == $0.superview!.top + Spec.textVerticalOffset * 2
        }
        
        backTextView.addSubview(subtitleLabel)
        constrain(subtitleLabel, titleLabel) {
            $0.leading == $0.superview!.leading + Spec.horrizontalOffset
            $0.trailing == $0.superview!.trailing - Spec.horrizontalOffset
            $0.top == $1.bottom + Spec.textVerticalOffset
            $0.bottom == $0.superview!.bottom - Spec.textVerticalOffset * 2
        }
        
    }
}

extension CarCell {
        
    static func getHeight(title: String) -> CGFloat {
//        let titleWidth = UIScreen.width
//            - Spec.horrizontalOffset * 2
//            - FavoritesViewController.PublicSpec.cvSideOffset * 2
//        let titleHeight = title.height(withConstrained: titleWidth, textStyle: Spec.titleStyle)
//        return titleHeight + Spec.verticalOffset * 2
        return CGFloat(200)
    }
    
}

