//
//  File.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 26/05/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable final class GradientButton: NtUibuttonGradiant {
    
    @IBInspectable var leftColor: UIColor = UIColor.clear
    @IBInspectable var rightColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        self.layer.addSublayer(gradient)
        
    }
    
}
