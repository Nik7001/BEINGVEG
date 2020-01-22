//
//  ArrayExtension.swift
//  Trunks
//
//  Created by Nitin Saklecha on 05/09/18.
//  Copyright © 2018 Arnasoftech. All rights reserved.
//

import UIKit

extension NSArray {
    
    func getInt(atIndex index: Int) -> Int {
        if self.count > index {
            if let intVal: Int = self.object(at: index) as? Int {
                return intVal
            } else if let numVal: NSNumber = self.object(at: index) as? NSNumber {
                return Int(truncating: numVal)
            } else if let strVal: String = self.object(at: index) as? String {
                if let intVal: Int = Int(strVal) {
                    return intVal
                }
            }
        }
        return 0
    }
    
    func getString(atIndex index: Int) -> String {
        if self.count > index {
            if let strVal: String = self.object(at: index) as? String {
                return strVal
            } else if let val: Bool = self.object(at: index) as? Bool {
                if val == true {
                    return "yes"
                } else {
                    return "no"
                }
            }
        }
        return ""
    }
    
    func getJsonString() -> String {
        var str: String = ""
        if self.count > 0 {
            do {
                if let postData : NSData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData? {
                    str = NSString(data: postData as Data, encoding: String.Encoding.utf8.rawValue)! as String
                }
            } catch {
                print(error)
            }
        }
        return str
    }
    
    
    func getFloat(atIndex index: Int) -> Float {
        if self.count > index {
            if let floatVal: Float = self.object(at: index) as? Float {
                return floatVal
            } else if let numVal: NSNumber = self.object(at: index) as? NSNumber {
                return Float(truncating: numVal)
            } else if let strVal: String = self.object(at: index) as? String {
                if let floatVal: Float = Float(strVal) {
                    return floatVal
                }
            }
        }
        return 0.0
    }
    
    func getDouble(atIndex index: Int) -> Double {
        if self.count > index {
            if let doubleVal: Double = (self.object(at: index) as AnyObject).doubleValue {
                return doubleVal
            } else if let numVal: NSNumber = self.object(at: index) as? NSNumber {
                return Double(truncating: numVal)
            } else if let strVal: String = self.object(at: index) as? String {
                if let doubleVal: Double = Double(strVal) {
                    return doubleVal
                }
            }
        }
        return 0.0
    }
    
    func getNSDictionary(atIndex index: Int) -> NSDictionary {
        if self.count > index {
            if let dictVal: NSDictionary = self.object(at: index) as? NSDictionary {
                return dictVal
            } else if let dictVal: NSMutableDictionary = self.object(at: index) as? NSMutableDictionary {
                return dictVal
            }
        }
        return NSDictionary()
    }
    
    func getNSMutableDictionary(atIndex index: Int) -> NSMutableDictionary {
        if self.count > index {
            if let dictVal: NSDictionary = self.object(at: index) as? NSDictionary {
                return NSMutableDictionary(dictionary: dictVal).mutableCopy() as! NSMutableDictionary
            } else if let dictVal: NSMutableDictionary = self.object(at: index) as? NSMutableDictionary {
                return NSMutableDictionary(dictionary: dictVal).mutableCopy() as! NSMutableDictionary
            }
        }
        return NSMutableDictionary()
    }
    
    func getNSArray(atIndex index: Int) -> NSArray {
        if self.count > index {
            if let arrVal: NSArray = self.object(at: index) as? NSArray {
                return arrVal
            } else if let arrVal: NSMutableArray = self.object(at: index) as? NSMutableArray {
                return arrVal
            }
        }
        return NSArray()
    }
    
    func getNSMutableArray(atIndex index: Int) -> NSMutableArray {
        if self.count > index {
            if let arrVal: NSArray = self.object(at: index) as? NSArray {
                return NSMutableArray(array: arrVal).mutableCopy() as! NSMutableArray
            } else if let arrVal: NSMutableArray = self.object(at: index) as? NSMutableArray {
                return NSMutableArray(array: arrVal).mutableCopy() as! NSMutableArray
            }
        }
        return NSMutableArray()
    }
    
  
    
    /*
     let yourArray = NSMutableArray()
     
     let dict = NSMutableDictionary()
     dict.hmSet(object: 1, forKey: "sdasdas")
     dict.hmSet(object: "dsfdsf", forKey: "dffdsf")
     
     yourArray.add(dict)
     yourArray.add(dict)
     
     
     */
    
}

