//
//  navigationVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 26/05/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class navigationVC: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()
        var bounds = navigationBar.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        gradient.colors = [UIColor.init(hexString:"#036D03").cgColor, UIColor.init(hexString:"#75DB60").cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
         // gradient.colors = [UIColor.init(red: 3, green: 109, blue: 3.0, alpha: 1.0), UIColor.blue.cgColor ,UIColor.init(red: 117.0, green: 219.0, blue: 96.0, alpha: 1.0)]
        
        if let image = getImageNavFrom(gradientLayer: gradient) {
            navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        }
    }
    
    func getImageNavFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}

