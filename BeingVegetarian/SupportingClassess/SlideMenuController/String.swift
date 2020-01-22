//
//  StringExtension.swift
//  SlideMenuControllerSwift
//
//  
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ n: Int = 0) -> String {
        return String(substring(n))
    }
    var length: String {
        return self.length
    }
    
}
