//
//  SliderView.swift
//  vtb-hack
//
//  Created by Semyon on 10.10.2020.
//

import UIKit
import Cartography

class SliderView: UIView {
    
    enum Spec {
        static let titleStyle = TextStyle.subhead3
        static let subTitleStyle = TextStyle.body1
        static let sliderValueStyle = TextStyle.subhead3
    }
    
    private let titleLabel = TSLabel() ~> {
        $0.textStyle = Spec.titleStyle.withColor(Color.VTB.ColdGray.coldGray40)
    }
    
    private let subTitleLabel = TSLabel() ~> {
        $0.textStyle = Spec.subTitleStyle
    }
    
    private let minValueLabel = TSLabel() ~> {
        $0.textStyle = Spec.sliderValueStyle.withColor(Color.VTB.ColdGray.coldGray40)
    }
    
    private let maxValueLabel = TSLabel() ~> {
        $0.textStyle = Spec.sliderValueStyle.withColor(Color.VTB.ColdGray.coldGray40)
    }
    
    private let slider = UISlider() ~> {
        $0.isContinuous = true
        $0.tintColor = Color.VTB.Blue.blue60
        $0.minimumTrackTintColor = Color.VTB.Blue.blue60
        $0.maximumTrackTintColor = Color.VTB.ColdGray.coldGray20
        $0.setThumbImage(UIImage(named: "Ellipse"), for: .normal)
    }
    
    // MARK: Public
    
    var value: Float? {
        return slider.value
    }
    
    func setup(title: String, initValue: Int, minValue: Int, maxValue: Int) {
        titleLabel.text = title
        subTitleLabel.text = format(from: Float(initValue)) ?? String(initValue)
        minValueLabel.text = format(from: Float(minValue)) ?? String(minValue)
        maxValueLabel.text = format(from: Float(maxValue)) ?? String(maxValue)
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        slider.setValue(Float(initValue), animated: true)
        sliderValueDidChange(value: Float(initValue))
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(titleLabel)
        constrain(titleLabel) {
            $0.leading == $0.superview!.leading + 16
            $0.trailing == $0.superview!.trailing - 16
            $0.top == $0.superview!.top + 16
            $0.height == Spec.titleStyle.lineHeight
        }
        
        addSubview(subTitleLabel)
        constrain(subTitleLabel, titleLabel) {
            $0.leading == $0.superview!.leading + 16
            $0.trailing == $0.superview!.trailing - 16
            $0.top == $1.bottom + 8
            $0.height == Spec.subTitleStyle.lineHeight
        }
        
        addSubview(slider)
        constrain(slider, subTitleLabel) {
            $0.leading == $0.superview!.leading + 16
            $0.trailing == $0.superview!.trailing - 16
            $0.top == $1.bottom + 4
        }
        
        addSubview(minValueLabel)
        constrain(minValueLabel) {
            $0.leading == $0.superview!.leading + 16
            $0.bottom == $0.superview!.bottom - 12
            $0.height == Spec.sliderValueStyle.lineHeight
        }
        
        addSubview(maxValueLabel)
        constrain(maxValueLabel) {
            $0.trailing == $0.superview!.trailing - 16
            $0.bottom == $0.superview!.bottom - 12
            $0.height == Spec.sliderValueStyle.lineHeight
        }
        
        constrain(self) {
            $0.height == 124
        }
        
        slider.addTarget(self, action: #selector(self.sliderValueAction(_:)), for: .valueChanged)
    }
    
    @objc
    func sliderValueAction(_ sender: UISlider!) {
        let step: Float = 1
        
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        
        sliderValueDidChange(value: roundedStepValue)
    }
    
    private func sliderValueDidChange(value: Float) {
        subTitleLabel.text = format(from: value)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.frame.width, height: 124)
    }
    
    private func format(from value: Float) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.groupingSeparator = "."
        return numberFormatter.string(from: NSNumber(value: value))
    }
}
