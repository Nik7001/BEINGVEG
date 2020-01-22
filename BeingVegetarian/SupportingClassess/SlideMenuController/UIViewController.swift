//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
        
        self.addLeftBarButtonWithImage(UIImage(named: "nav_btn")!)
        self.addRightBarButtonWithImage()
        //self.addRightBarButtonWithImage(UIImage(named: "rightIcon")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
        
        let gradient = CAGradientLayer()
        
        var bounds = navigationController?.navigationBar.bounds
        bounds!.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds!
        gradient.colors = [UIColor.init(hexString:"#036D03").cgColor, UIColor.init(hexString:"#75DB60").cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        if let image = getImageFrom(gradientLayer: gradient) {
        navigationController!.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        }
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }

func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
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
