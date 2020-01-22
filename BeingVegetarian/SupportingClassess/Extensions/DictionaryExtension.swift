//
//  DictionaryExtension.swift
//  Trunks
//
//  Created by Nitin Saklecha on 05/09/18.
//  Copyright © 2018 Arnasoftech. All rights reserved.
//

import UIKit

extension NSDictionary {
    
    func GetObject(forKey key: String) -> Any? {
        return self.object(forKey: key)
    }
    
    func DictionaryToString() -> String {
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: self, options:  JSONSerialization.WritingOptions.prettyPrinted)
            if let encodedString: String = String(data: jsonData, encoding: String.Encoding.utf8) {
                return encodedString
            }
        } catch let err {
            print("err >>>> \(err)")
        }
        return ""
    }
    
    func getJsonString() -> String {
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: self, options:  JSONSerialization.WritingOptions.prettyPrinted)
            if let encodedString: String = String(data: jsonData, encoding: String.Encoding.utf8) {
                return encodedString
            }
        } catch let err {
            print("err >>>> \(err)")
        }
        return ""
    }
    
    func GetInt(forKey key: String) -> Int {
        if let intVal: Int = self.object(forKey: key) as? Int {
            return intVal
        } else if let numVal: NSNumber = self.object(forKey: key) as? NSNumber {
            return Int(truncating: numVal)
        } else if let strVal: String = self.object(forKey: key) as? String {
            if let intVal: Int = Int(strVal) {
                return intVal
            }
        }
        return 0
    }
    
    func GetString(forKey key: String) -> String {
        if let strVal: String = self.object(forKey: key) as? String {
            return strVal
        } else if let val: Bool = self.object(forKey: key) as? Bool {
            if val == true {
                return "yes"
            } else {
                return "no"
            }
        }
        return ""
    }
    
    func GetFloat(forKey key: String) -> Float {
        if let floatVal: Float = self.object(forKey: key) as? Float {
            return floatVal
        } else if let numVal: NSNumber = self.object(forKey: key) as? NSNumber {
            return Float(truncating: numVal)
        } else if let strVal: String = self.object(forKey: key) as? String {
            if let floatVal: Float = Float(strVal) {
                return floatVal
            }
        }
        return 0.0
    }
    
    func GetDouble(forKey key: String) -> Double {
        if let doubleVal: Double = (self.object(forKey: key) as AnyObject).doubleValue {
            return doubleVal
        } else if let numVal: NSNumber = self.object(forKey: key) as? NSNumber {
            return Double(truncating: numVal)
        } else if let strVal: String = self.object(forKey: key) as? String {
            if let doubleVal: Double = Double(strVal) {
                return doubleVal
            }
        }
        return 0.0
    }
    
    func GetNSDictionary(forKey key: String) -> NSDictionary {
        if let dictVal: NSDictionary = self.object(forKey: key) as? NSDictionary {
            return dictVal
        } else if let dictVal: NSMutableDictionary = self.object(forKey: key) as? NSMutableDictionary {
            return dictVal
        }
        return NSDictionary()
    }
    
    func GetNSMutableDictionary(forKey key: String) -> NSMutableDictionary {
        if let dictVal: NSDictionary = self.object(forKey: key) as? NSDictionary {
            return NSMutableDictionary(dictionary: dictVal).mutableCopy() as! NSMutableDictionary
        } else if let dictVal: NSMutableDictionary = self.object(forKey: key) as? NSMutableDictionary {
            return NSMutableDictionary(dictionary: dictVal).mutableCopy() as! NSMutableDictionary
        }
        return NSMutableDictionary()
    }
    
    func GetNSArray(forKey key: String) -> NSArray {
        if let arrVal: NSArray = (self.object(forKey: key) as AnyObject) as? NSArray {
            return arrVal
        } else if let arrVal: NSMutableArray = self.object(forKey: key) as? NSMutableArray {
            return arrVal
        }
        return NSArray()
    }
    
    func GetNSMutableArray(forKey key: String) -> NSMutableArray {
        if let arrVal: NSArray = self.object(forKey: key) as? NSArray {
            return NSMutableArray(array: arrVal).mutableCopy() as! NSMutableArray
        } else if let arrVal: NSMutableArray = self.object(forKey: key) as? NSMutableArray {
            return NSMutableArray(array: arrVal).mutableCopy() as! NSMutableArray
        }
        return NSMutableArray()
    }
    
}

extension NSMutableDictionary {
    
    func Set(object: Any, forKey key: String!) {
        self.setObject(object, forKey: key as NSCopying)
    }
    
    func Set(value: Any, forKey key: String!) {
        if self.object(forKey: key) != nil {
            self.setObject(value, forKey: key as NSCopying)
        } else {
            self.setValue(value, forKey: key)
        }
    }
    
    func Replace(object: Any, forKey key: String!) {
        self.Set(value: object, forKey: key)
    }
    
    func ReomoveObject(forKey key: String!) {
        self.removeObject(forKey: key)
    }
    
    func ReomoveObjects(forKeys keys: [String]!) {
        self.removeObjects(forKeys: keys)
    }
    
    func ReomoveAllObject(forKey key: String!) {
        self.removeAllObjects()
    }
}


extension String {
    
    func test() -> String {
        let str = self + "test"
        return str
    }
    
}

