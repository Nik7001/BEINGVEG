//
//  MessageStringFile.swift
//  Trunks
//
//  Created by Nitin Saklecha on 05/09/18.
//  Copyright © 2018 Arnasoftech. All rights reserved.

import Foundation
import UIKit

class MessageStringFile: NSObject {
    
    class func serverError() -> String {
        return "Problem retrieving data from server due to connectivity issue."
    }
    
    class func networkReachability() -> String {
        return "There's no network connection right now. Please check your Wifi connection or mobile data."
    }
    
    class func unableToGetLocationFromAddress() -> String {
        return "We’re unable to find a location at the address you gave. Please enter a more specific address."
    }
    
    class func vInfoNeeded() -> String {
        return "We need just a few more details:"
    }
    
    class func popUpSting() -> String {
        return "We need just a few more details:"
    }
    
    class func messageText() -> String {
        return "Message"
    }
    
    class func whoopsText() -> String {
        return "Whoops!"
    }
    class func FeedbackText() -> String {
        return "Thanks For Your Feedback!"
    }
    class func SuccessText() -> String {
        return "Added Successfully"
    }
    class func retryText() -> String {
        return "Retry"
    }
    class func removeText() -> String {
        return "Removed Successfully"
    }
    //Verification Code
    class func vVerificationCode() -> String {
        return "Mobile Verification Code"
    }
    
    class func vEmailVerificationCode() -> String {
        return "Verification Code"
    }
    
    class func vEmailVerificationvalid() -> String {
        return "Valid Verification Code"
    }
    class func successText() -> String {
        return "Success"
    }
    
    class func sorryText() -> String {
        return "Sorry"
    }
    
    class func thanksText() -> String {
        return "THANK YOU"
    }
    class func okText() -> String {
        return "OK"
    }
    
    class func cancelText() -> String {
        return "CANCEL"
    }
    
    class func notNowText() -> String {
        return "NOT NOW"
    }
    
    class func yesText() -> String {
        return "YES"
    }
    
    class func noText() -> String {
        return "NO"
    }
    
    class func confirmText() -> String {
        return "Confirmation"
    }
    
    class func viewTxt() -> String {
        return "VIEW"
    }
    
    class func vEmail() -> String {
        return "Email"
    }
    class func restorantName() -> String {
        return "enter restorantName"
    }
    
    
    class func vContect() -> String {
        return "Contact Number"
    }
    class func vEmailNotValid() -> String {
        return "Please enter valid email id"
    }
    
    class func VTermsCondititons() -> String {
        return "Please accept Terms and Condition "
    }
    
    
    class func vFirstname() -> String {
        return "Please enter Firstname"
    }
    class func vSavemiles() -> String {
        return "Please enter the amount you spend on public transportation each day."
    }
    class func vDrivemiles() -> String {
        return "Please enter the number of miles that you drive per week"
    }
    class func vmpgmiles() -> String {
        return "Please let us know how many miles per gallon your vehicle gets"
    }
    class func vLastname() -> String {
        return "Please enter Lastname"
    }
    class func vPassword() -> String {
        return "Password"
    }
    class func vSourcelocation() -> String {
        return "Enter Your Source location"
    }
    class func vDestinationlocation() -> String {
        return "Enter Your Destination location"
    }
    class func vAlertAddLocation() -> String {
        return "Enter Your faviorate name "
    }
    
    class func vConfirmPassword() -> String {
        return "Confirm Password"
    }
    
    class func vValidEmail() -> String {
        return "Valid email"
    }
    
    class func vPasswordAndConfirmPasswordNotMatch() -> String {
        return "Password doesn’t match"
    }
    
    class func vOldPassword() -> String {
        return "Old password"
    }
    
    class func vNewPassword() -> String {
        return "New password"
    }
    
    class func vPasswordLength() -> String {
        return "Password should be at least 6 characters long."
    }
    class func vcalcutationLength() -> String {
        return " At least Enter 10  Digit Number."
    }
 
    class func vValidFullName() -> String {
        return "At least enter 2 character"
    }
    
    
    class func vFirstName() -> String {
        return "First Name"
    }
    class func vmessage() -> String {
        return "Add a message"
    }
    class func vtitle() -> String {
        return "Enter Title"
    }
    class func area() -> String {
        return "enter restorant address"
    }
    
    override class func description() -> String {
        return "enter restorant description"
    }
    class func openingtime() -> String {
        return "enter restorant opening time"
    }
    class func closingTime() -> String {
        return "enter restorant closing time"
    }
    
    class func vLastName() -> String {
        return "Last Name"
    }
    class func vguest() -> String {
        return "Please Enter Guest"
    }
    class func vselectContry() -> String {
        return "Please Select Country"
    }
    class func vMobile() -> String {
        return "Mobile Number"
    }
    
    class func vValidMobile() -> String {
        return "Please enter valid mobile number."
    }
    
    class func vEmailPassword() -> String {
        return "Please enter email/mobile number and password"
    }
    
    class func vEmailPhoneNumber() -> String {
        return "Email or Mobile Number."
    }
    
    class func vAddress() -> String {
        return "Address"
    }
    
    class func vNewNumber() -> String {
        return "New number should be different from existing number."
    }
    
    class func strResendCodeIn() -> String {
        return "Resend Code in "
    }
    
    class func strResendCode() -> String {
        return "Resend Code"
    }
    //vOldPasswordAndNewPasswordNotSame()
    class func vOtp() -> String {
        return "Enter OTP"
    }
   
  
    class func strOldPasswordAndNewPasswordNotSame() -> String {
        return "Current Or New Password Same"
    }
    
    class func please_add_address_type()->String{
        return "Please add Address Type"
    }
    
    //vQuery()
    
    class func vQuery() -> String {
        return "Message"
    }
    //Terms and condition
    static let termCondition = "Terms and Condition"
    static let privacyPolicy = "Privacy Policy"
    //Add card
    static let strCardHolderName = "Card Holder Name"
    static let strCardNumber = "Card Number"
    static let strVaildCardNumber = "Valid Card Number"
    static let strEDate = "Expire Date"
    static let strCvv = "CVV Number"
    static let strValidCVV = "Valid CVV Number"
   
}

class PlaceHolderTxt: NSObject {
    class func fullName() -> String {
        return "Full Name"
    }
    class func email() -> String {
        return "Email"
    }
    class func mobile() -> String {
        return "Mobile Number"
    }
    class func password() -> String {
        return "Password"
    }
    class func confirmPwd() -> String {
        return "Confirm Password"
    }
    //Login
    class func emailOrPhoneNumber() -> String {
        return "Email or Mobile Number"
    }
}

class PredefinedConstants: NSObject {
    static  let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static  let userDeviceId = UIDevice.current.identifierForVendor!.uuidString
    
    static  let userDeviceName = UIDevice.current.model
    static  let deviceOSVersion = NSString(string: UIDevice.current.systemVersion).floatValue
    static  let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    static  let screenWidth = UIScreen.main.bounds.width
    static  let screenHeight = UIScreen.main.bounds.height
    static  let deviceType = "iphone"
    static  let makeModel = UIDevice.current.localizedModel
    static  let os = UIDevice.current.systemVersion
    static  let currentWindow: UIWindow = UIApplication.shared.keyWindow!
    static  let cornerBoderRadiousLoginButton: CGFloat = 4.0
    static  let limitOfPagination = 20
    static  let textFieldCornerRadius = 22.5
     static  let btnCornerRadius = 22.5
    static var popUpCheck:String = ""
   
   
    
}

