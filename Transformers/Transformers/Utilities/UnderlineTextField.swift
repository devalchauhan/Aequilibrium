//
//  UnderlineTextField.swift
//  Transformers
//
//  Created by Deval Chauhan on 01/06/20.
//  Copyright © 2020 Deval. All rights reserved.
//

import UIKit

protocol UnderlineTextFieldDelegate: NSObjectProtocol {
    func textFieldDidDelete(_ textField: UnderlineTextField)
}

@IBDesignable
class UnderlineTextField: UITextField {

    // MARK: - Public Properties
    
    weak var deleteDelegate: UnderlineTextFieldDelegate?
    
    /// Adds padding around text field.
    var edgeInsets: UIEdgeInsets = .zero
    
    /// Padding above and below the text field, between the placeholder label and underline.
    @IBInspectable var textPadding: CGFloat = 0.0
    
    /// The height of the underline when the text field has no text.
    @IBInspectable var underlineHeight: CGFloat = 0.0
    
    /// The height of the underline when the text field has text.
    @IBInspectable var underlineEditingHeight: CGFloat = 0.0
    
    /// The color of the underline when the text field has no text.
    @IBInspectable var underlineColor: UIColor?
    
    /// The color of the underline when the text field has text.
    @IBInspectable var underlineEditingColor: UIColor?
    
    // MARK: - Private Properties
    
    private var underlineLayer = CALayer()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds.inset(by: edgeInsets))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds.inset(by: edgeInsets))
    }
    
    // MARK: - Setup
    
    func setupViews() {
        
        textPadding = 8.0
        underlineEditingColor = .white
        underlineColor = .white
        underlineHeight = 1.0
        underlineEditingHeight = 1.0
        edgeInsets = .init(top: 0, left: 0, bottom: underlineHeight, right: 0)
        
        setupUnderline()
    }
    
    fileprivate func setupUnderline() {
        underlineLayer = CALayer()
        layoutUnderlineLayer()
        layer.addSublayer(underlineLayer)
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutUnderlineLayer()
    }
    
    fileprivate func layoutUnderlineLayer() {
        updateUnderlineColor()
        updateUnderlineFrame()
    }
    
    // MARK: - Underline
    
    func updateUnderlineColor() {
        underlineLayer.backgroundColor = underlineColor?.cgColor
    }
    
    func updateUnderlineFrame() {
        let width = NumberFormatter().number(from: self.text ?? "") ?? 0
        underlineLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width * (CGFloat(truncating: width) * 10)/100 , height: 30)
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        
        deleteDelegate?.textFieldDidDelete(self)
    }
}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func toInt() -> Int? {
        return NumberFormatter().number(from: self)?.intValue
    }
}

extension UIView {

    func shake(count : Float = 3,for duration : TimeInterval = 0.4,withTranslation translation : Float = 4) {

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}
