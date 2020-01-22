//
//  UIViewExtension.swift
//  Trunks
//
//  Created by Nitin Saklecha on 05/09/18.
//  Copyright © 2018 Arnasoftech. All rights reserved.
//
import UIKit
import MapKit

extension UIView {
    
    func zoomInWithScale() {
        self.transform = CGAffineTransform.identity.scaledBy(x: 0.001, y: 0.001)
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform.identity.scaledBy(x: 1.05, y: 1.05)
        }, completion: { (finish) in
            UIView.animate(withDuration: 0.15, animations: {
                self.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.15, animations: {
                    self.transform = CGAffineTransform.identity
                })
            })
        })
    }
    
    func setCornerRadiousAndBorder(_ color: UIColor, borderWidth: CGFloat) {
        self.layer.cornerRadius = 5
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
    
    func setCornerBorder(_ color: UIColor, borderWidth: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
    
    func setCornerRadiousAndBorder(_ color: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
    
    func circleView(_ color: UIColor, borderWidth: CGFloat) {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
    
    func setShadowOnView(_ shadowColor: UIColor) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func setShadowOnViewWithRadious(_ shadowColor: UIColor, shadowRadius: CGFloat) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.cornerRadius = shadowRadius
        self.clipsToBounds = false
    }
    
    func setShadowOnViewWithRadious(_ shadowColor: UIColor, shadowRadius: CGFloat, shadowOffset: CGSize) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
    }
    
    
    
    
    func dropViewWithBounce() {
        self.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            var frame: CGRect = self.frame
            frame.origin.y = self.superview!.center.y - 100
            self.frame = frame
            self.alpha = 1.0
        }, completion: { (completed) -> Void in
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                self.center = self.superview!.center
            })
        })
    }
    
    func pullViewToTop() {
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alpha = 0.0
            var frame: CGRect = self.frame
            frame.origin.y = -500
            self.frame = frame
        }, completion: { (completed) -> Void in
        })
    }
    
    func pullViewFromBottom() {
        self.alpha = 0.0
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alpha = 1.0
            self.frame.origin.y = self.superview!.frame.size.height - self.frame.size.height
        })
    }
    
    func hideViewToBottom() {
        self.alpha = 1.0
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alpha = 0.0
            self.frame.origin.y = self.superview!.frame.size.height + 10
        })
    }
    
    func AddActivityInducator(style s: UIActivityIndicatorView.Style? = nil, color c: UIColor? = nil, coordinate p: CGPoint? = nil) {
        let style: UIActivityIndicatorView.Style!
        if let s = s {
            style = s
        } else {
            style = UIActivityIndicatorView.Style.gray
        }
        let avi = UIActivityIndicatorView(style: style)
        if let c = c {
            avi.color = c
        }
        avi.startAnimating()
        avi.tag = 401223564
        if let p = p {
            avi.frame.origin = p
        } else {
            avi.frame.origin = CGPoint(x: (self.frame.size.width * 0.5) - (avi.frame.size.width * 0.5), y: (self.frame.size.height * 0.5) - (avi.frame.size.height * 0.5))
        }
        self.addSubview(avi)
    }
    
    func RemoveActivityInducator() {
        if let avi = self.viewWithTag(401223564) {
            avi.removeFromSuperview()
        }
    }
   
}


extension UIView {
    /**
     Simply zooming in of a view: set view scale to 0 and zoom to Identity on 'duration' time interval.
     
     - parameter duration: animation duration
     */
    func zoomIn(duration: TimeInterval = 0.2) {
        self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform.identity
        }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    /**
     Simply zooming out of a view: set view scale to Identity and zoom out to 0 on 'duration' time interval.
     
     - parameter duration: animation duration
     */
    func zoomOut(duration: TimeInterval = 0.2) {
        self.transform = CGAffineTransform.identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    /**
     Zoom in any view with specified offset magnification.
     
     - parameter duration:     animation duration.
     - parameter easingOffset: easing offset.
     */
    func zoomInWithEasing(duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
        UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
        }, completion: { (completed: Bool) -> Void in
            UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                self.transform = CGAffineTransform.identity
            }, completion: { (completed: Bool) -> Void in
            })
        })
    }
    
    func zoomOutWithEasing(duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
        UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
        }, completion: { (completed: Bool) -> Void in
            UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            }, completion: { (completed: Bool) -> Void in
            })
        })
    }
    
    func shake(count : Float? = nil,for duration : TimeInterval? = nil,withTranslation translation : Float? = nil) {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count ?? 2
        animation.duration = (duration ?? 0.5)/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation ?? -5
        layer.add(animation, forKey: "shake")
    }
}
extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: thickness, height: frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect.init(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
}
extension MKMapView {
    
    func ReloadMap() {
        if self.annotations.count > 0 {
            let ann = self.annotations
            self.removeAnnotations(ann)
            self.addAnnotations(ann)
        }
    }
    
    func zoomToFitAllOverlays() {
        if let over = self.overlays.first {
            var regionRect = over.boundingMapRect
            let wPadding = regionRect.size.width * 0.25
            let hPadding = regionRect.size.height * 0.25
            regionRect.size.width += wPadding
            regionRect.size.height += hPadding
            regionRect.origin.x -= wPadding / 2
            regionRect.origin.y -= hPadding / 2
            self.setRegion(MKCoordinateRegion.init(regionRect), animated: false)
        }
    }
    
    
}
