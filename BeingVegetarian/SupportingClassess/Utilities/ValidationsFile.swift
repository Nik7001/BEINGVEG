//
//  ValidationsFile.swift
//  Trunks
//
//  Created by Nitin Saklecha on 05/09/18.
//  Copyright © 2018 Arnasoftech. All rights reserved.
//
import UIKit

class ValidationsFile: NSObject {
    static let emailAcceptableCharacter = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.-@"
    static let AddressAcceptableCharacter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890,/- "
    static  let NameAcceptableCharacter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ. "
    static  let ZipCodeAcceptableCharacter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890- "
    static  let numberAcceptableCharacter = "1234567890"
    static  let decimalAcceptableCharacter = "1234567890."
    static let MessageAcceptableCharacter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ,/-. ?"
    static let offerCode = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "
    static let alphaNumericAccept = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

  static let phoneNoAcceptableCharacter = "1234567890"
    class   func isValidEmail(strEmail:String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
            return regex.firstMatch(in: strEmail, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, strEmail.count)) != nil
        } catch {
            return false
        }
    }
    
    
 class   func checkEnterFloatInTextFiled(strValue : String) -> Bool{
        if let BudgetValue : Float  = Float(strValue){
            if BudgetValue <= Float(10000.00){
                let arrFloatBrack : [String] = strValue.components(separatedBy: ".")
                if arrFloatBrack.count >= 2{
                    let afterDot = arrFloatBrack[1]
                    if afterDot.count <= 2{
                        return true
                    }
                    return false
                }
                return true
            }
        }
        return false
    }
    
    class func trimString(tempString : String)-> String{
        let trimmedString = tempString.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedString
    }
    
    class func isValidLinkOrUrl(testStr:String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
            return regex.firstMatch(in: testStr, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, testStr.count)) != nil
        } catch {
            return false
        }
    }
    
}

