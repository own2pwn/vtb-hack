//
//  ShadowableCollectionViewCell.swift
//  vtb-hack
//
//  Created by Semyon on 09.10.2020.
//

import UIKit

class ShadowableCollectionViewCell: UICollectionViewCell {
    
    private lazy var shadowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()

        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)

        return layer
    }()

    private var lastShadowBounds: CGRect = .zero

    override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        internalInit()
    }

    private func internalInit() {
        clipsToBounds = false
        layer.insertSublayer(shadowLayer, at: 0)
        setupContentView()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }

    override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
        super.touchesEstimatedPropertiesUpdated(touches)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3, animations: transform)
        super.touchesBegan(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3, animations: resetTransform)
        super.touchesEnded(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3, animations: resetTransform)
        super.touchesCancelled(touches, with: event)
    }

    private func transform() {
        transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        contentView.backgroundColor = Color.lightGray.dynamicForDark(Color.darkPink)
    }

    private func resetTransform() {
        transform = .identity
        contentView.backgroundColor = Color.white.dynamicForDark(Color.darkBlue)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutShadow()
    }

    private func layoutShadow() {
        guard lastShadowBounds != contentView.bounds else { return }
        defer { lastShadowBounds = contentView.bounds }

        let path = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius)
        shadowLayer.shadowPath = path.cgPath
    }
    
    private func setupContentView() {
        let layer = contentView.layer
        layer.cornerRadius = 6
    }
}

