//
//  UIView+Extensions.swift
//  cinema
//
//  Created by Alicia Monserrath Castro Hernandez on 12/12/20.
//

import Foundation
import UIKit

extension UIView {
    func roundingCorners(_ corners: UIRectCorner) {
        if corners.contains(.allCorners) {
            self.layer.cornerRadius = 20.0
        } else {
            self.layer.cornerRadius = 0.0
            let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(roundedRect: self.bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: 20.0, height: 20.0)).cgPath
            self.layer.mask = maskLayer
        }
    }
}
