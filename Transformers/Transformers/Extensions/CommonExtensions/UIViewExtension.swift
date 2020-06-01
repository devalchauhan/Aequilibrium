//
//  UIViewExtension.swift
//  Transformers
//
//  Created by Deval Chauhan on 31/05/20.
//  Copyright © 2020 Deval. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundedBottomCorner() {
        let rectShape = CAShapeLayer()
        rectShape.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 20, height: self.bounds.size.height), byRoundingCorners:[.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath
        self.layer.mask = rectShape
    }
    func roundedTopCorner() {
        let rectShape = CAShapeLayer()
        rectShape.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 20, height: self.bounds.size.height), byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath
        self.layer.mask = rectShape
    }
    func roundedAllCorner() {
        let rectShape = CAShapeLayer()
        rectShape.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 20, height: self.bounds.size.height), byRoundingCorners:[.topLeft, .topRight,.bottomRight,.bottomLeft], cornerRadii: CGSize(width: 15, height: 15)).cgPath
        self.layer.mask = rectShape
    }
    func roundedButtonAllCorner() {
        let rectShape = CAShapeLayer()
        rectShape.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width/2 - 20, height: self.bounds.size.height), byRoundingCorners:[.topLeft, .topRight,.bottomRight,.bottomLeft], cornerRadii: CGSize(width: 15, height: 15)).cgPath
        self.layer.mask = rectShape
    }
}
