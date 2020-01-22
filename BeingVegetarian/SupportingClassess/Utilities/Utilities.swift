//
//  Utilities.swift
//  Trunks
//
//  Created by Nitin Saklecha on 05/09/18.
//  Copyright © 2018 Arnasoftech. All rights reserved.
//
import UIKit

class HelperClass: NSObject {
    
    //MARK: Internet
    
    class var isInternetAvailable: Bool {
        get {
            let tempAppDelegate = UIApplication.shared.delegate as! AppDelegate
            if tempAppDelegate.reachability == nil {
                tempAppDelegate.reachability = Reachability()!
            }
            if tempAppDelegate.reachability!.isReachable {
                return true
            }
            return false
        }
    }
    
    //GetErrorMsg
    func getErrorMsg(dictData:NSDictionary) -> String {
        var strMsg = ""
        if dictData.count != 0{
            if !(dictData.object(forKey: "error") is NSNull) && dictData.object(forKey: "error") != nil{
                if let dictError : NSDictionary = dictData.object(forKey: "error") as? NSDictionary{
                    if !(dictError.object(forKey: "message") is NSNull) && dictError.object(forKey: "message") != nil{
                        if let strErrorMsg : String = dictError.object(forKey: "message") as? String{
                            strMsg = strErrorMsg
                        }
                    }
                }
            }
        }
        return strMsg
    }
    
    //MARK: Check
    
    class func checkObjectInDictionaryWithNoDecimal(dictH: NSDictionary, strObject: String) -> String {
        return checkObjectInDictionary(dictH: dictH, strObject: strObject, pointValue: 0)
    }
    
    class func checkObjectInDictionary(dictH: NSDictionary, strObject: String) -> String {
        return checkObjectInDictionary(dictH: dictH, strObject: strObject, pointValue: 2)
    }
    
    class func checkObjectInDictionary(dictH: NSDictionary, strObject: String, pointValue: Int) -> String {
        var strHoney: String = ""
        if !(dictH.GetObject(forKey: strObject) is NSNull) && dictH.GetObject(forKey: strObject) != nil {
            if (dictH.GetObject(forKey: strObject) as? NSNumber != nil) {
                let numH = dictH.GetObject(forKey: strObject) as? NSNumber
                let floatH = numH?.floatValue
                if pointValue == 0 {
                    strHoney = NSString(format: "%.0f", floatH!) as String
                } else if pointValue == 1 {
                    strHoney = NSString(format: "%.1f", floatH!) as String
                } else if pointValue == 2 {
                    strHoney = NSString(format: "%.2f", floatH!) as String
                } else if pointValue == 3 {
                    strHoney = NSString(format: "%.3f", floatH!) as String
                } else if pointValue == 4 {
                    strHoney = NSString(format: "%.4f", floatH!) as String
                } else if pointValue == 5 {
                    strHoney = NSString(format: "%.5f", floatH!) as String
                } else if pointValue == 6 {
                    strHoney = NSString(format: "%.6f", floatH!) as String
                } else if pointValue == 7 {
                    strHoney = NSString(format: "%.7f", floatH!) as String
                } else if pointValue == 8 {
                    strHoney = NSString(format: "%.8f", floatH!) as String
                } else if pointValue == 9 {
                    strHoney = NSString(format: "%.9f", floatH!) as String
                } else if pointValue == 10 {
                    strHoney = NSString(format: "%.10f", floatH!) as String
                } else {
                    strHoney = NSString(format: "%.11f", floatH!) as String
                }
            } else if (dictH.GetObject(forKey: strObject) as? String != nil){
                strHoney = dictH.GetObject(forKey: strObject) as! String
            }
        }
        return strHoney
    }
    
//    class func checkObjectInDictionaryFloat(dictH: NSDictionary, strObject: String, pointValue: Int) -> String {
//        var strHoney: String = ""
//        if !(dictH.GetObject(forKey: strObject) is NSNull) && dictH.GetObject(forKey: strObject) != nil {
//            if (dictH.GetObject(forKey: strObject) as? NSNumber != nil) {
//                let numH = dictH.GetObject(forKey: strObject) as? NSNumber
//                let floatH = numH?.floatValue
//                if pointValue == 0 {
//                    strHoney = NSString(format: "%.0f", floatH!) as String
//                } else if pointValue == 1 {
//                    strHoney = NSString(format: "%.1f", floatH!) as String
//                } else if pointValue == 2 {
//                    strHoney = NSString(format: "%.2f", floatH!) as String
//                }
//            } else if (dictH.GetObject(forKey: strObject) as? String != nil){
//               // strHoney = dictH.GetObject(forKey: strObject) as! String
//                let String = dictH.GetObject(forKey: strObject) as? String
//                //let floatH = numH?.String
//                strHoney = String(format:"%.2f",String)
//            }
//        }
//        return strHoney
//    }
    
    class func setObjectInNSDictionary(dict: NSDictionary!, key: String!, object: Any!) -> NSDictionary {
        let mutableDict = NSMutableDictionary(dictionary: dict).mutableCopy() as! NSMutableDictionary
        mutableDict.Set(value: object, forKey: key)
        let newDict = NSDictionary(dictionary: mutableDict)
        return newDict
    }
    
    class func openUrl(str: String) {
        if let url = URL(string: str) {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: { (completed) in
                        
                    })
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    class func makeACall(phoneNumber: String, completionHandler completion: ((Bool) -> Swift.Void)? = nil) {
        var strUrl = phoneNumber
        if phoneNumber.range(of: "tel://") == nil {
            strUrl = "tel://" + phoneNumber
        }
        if let url = URL(string: strUrl) {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: completion)
                } else {
                    UIApplication.shared.openURL(url)
                    if completion != nil {
                        completion!(true)
                    }
                }
            }
        }
    }
    
    class func GetTextSize(text: String, font: UIFont, boundedBySize: CGSize) -> CGSize {
        let attrString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: font])
        let size = attrString.boundingRect(with: boundedBySize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).size
        return size
    }
    
    class func startIgnoringInteractionEvent() {
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    class func endIgnoringInteractionEvent() {
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    class func textWithImage(image: UIImage?, str: String) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0.0, y: 5.0, width: attachment.image!.size.width, height: attachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(attributedString: attachmentString)
        myString.append(NSAttributedString(string: str))
        return myString
    }
    
    class func createAttributedString(mainString str1: String, stringToColor str2: String, font: UIFont?, color: UIColor?) -> NSAttributedString {
        let strToUnchangeChanege = NSMutableAttributedString(string: str1)
        var attributes: [NSAttributedString.Key: Any] = [:]
        if let f = font {
            attributes[NSAttributedString.Key.font] = f
        }
        if let c = color {
            attributes[NSAttributedString.Key.foregroundColor] = c
        }
        let strToChange = NSMutableAttributedString(string: str2, attributes: attributes)
        strToUnchangeChanege.append(strToChange)
        return strToUnchangeChanege
    }
    
    class func createAttributedString(mainString str1: String, stringToColor str2: String, font: UIFont?, color: UIColor?, underLine: Bool) -> NSAttributedString {
        let strToUnchangeChanege = NSMutableAttributedString(string: str1)
        var attributes: [NSAttributedString.Key: Any] = [:]
        if let f = font {
            attributes[NSAttributedString.Key.font] = f
        }
        if let c = color {
            attributes[NSAttributedString.Key.foregroundColor] = c
        }
        if underLine {
            attributes[NSAttributedString.Key.underlineStyle] = NSNumber(value: 1)
        }
        let strToChange = NSMutableAttributedString(string: str2, attributes: attributes)
        strToUnchangeChanege.append(strToChange)
        return strToUnchangeChanege
    }
    
    class func createAttributedString(fullString str1: String, stringToChange str2: String, font: UIFont?, color: UIColor?, underLine: Bool) -> NSAttributedString {
        
        /*
         let byClickingSignUp = MessageStringFile.byClickingSignUp()
         let string_to_underline = MessageStringFile.termsAndConditions()
         let range1 = (byClickingSignUp as NSString).range(of: string_to_underline)
         let attributedString1 = NSMutableAttributedString(string: byClickingSignUp)
         attributedString1.addAttribute(NSUnderlineStyleAttributeName, value: NSNumber(value: 1), range: range1)
         let fullRange = (byClickingSignUp as NSString).range(of: byClickingSignUp)
         attributedString1.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: fullRange)
         btnTermsCondition.setAttributedTitle(attributedString1, for: UIControlState.normal)
         */
   
         let string_to_change = str2
         let attributedString = NSMutableAttributedString(string: str1)
         let range = (str1 as NSString).range(of: string_to_change)
         if let font = font {
            attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
         }
         if let color = color {
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
         }
        
        
       /* let strToUnchangeChanege = NSMutableAttributedString(string: str1)
        var attributes: [NSAttributedStringKey: Any] = [:]
        if let f = font {
            attributes[NSAttributedStringKey.font] = f
        }
        if let c = color {
            attributes[NSAttributedStringKey.foregroundColor] = c
        }
        if underLine {
            attributes[NSAttributedStringKey.underlineStyle] = NSNumber(value: 1)
        }
        let strToChange = NSMutableAttributedString(string: str2, attributes: attributes)
        strToUnchangeChanege.append(strToChange)*/
        return attributedString
    }
    
    
    class func animateViewHoney(viewHoney: UIImageView, imageHoney: UIImage) {
        viewHoney.transform = CGAffineTransform.identity.scaledBy(x: 0.001, y: 0.001)
        UIView.animate(withDuration: 0.3/1.5, animations: { () -> Void in
            viewHoney.image = imageHoney
            viewHoney.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
        }) { (finished) -> Void in
            UIView.animate(withDuration: 0.3/2 , animations: { () -> Void in
                viewHoney.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            }, completion: { (finished) -> Void in
                viewHoney.transform = CGAffineTransform.identity
            })
        }
    }
    
    class func removeNullValuesFromUserInfo(dictTemp: NSMutableDictionary)-> NSMutableDictionary{
        let keys = dictTemp.allKeys
        for key in keys{
            if dictTemp.object(forKey: key) is NSNull{
                dictTemp.setObject("", forKey: key as! NSCopying)
            }
        }
        return dictTemp
    }
    
    
   /* class  func getHeader() -> String {
        if AppUserDefault.getDictUserDetail() != nil {
            let token = HelperClass.checkObjectInDictionaryWithNoDecimal(dictH: AppUserDefault.getDictUserDetail()!, strObject: WebServiceContant.token)
            return "\(token)"
        }
       return ""
    }*/
    
   /* class func getUserId() -> String {
        let _id = HelperClass.checkObjectInDictionaryWithNoDecimal(dictH: AppUserDefault.getUserInfo(), strObject: WebServicesConstants.id)
        return _id
    }*/
    
    class func getTimeStringWithoutUTC(dictH: NSDictionary,strDate : String) -> (date: String, dateTime: String, time: String) {
        let dd = HelperClass.checkObjectInDictionaryWithNoDecimal(dictH: dictH, strObject: strDate)
        
        if dd != "" {
            var dateShow = ""
            var dateTimeShow = ""
            var timeShow = ""
            var dateFromate = DateFormatter()
            dateFromate.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if  let date = dateFromate.date(from: dd) {
                dateFromate.dateFormat = "h:mm a"
                timeShow = dateFromate.string(from: date)
            }
            
            dateFromate = DateFormatter()
            dateFromate.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if  let date1 = dateFromate.date(from: dd) {
                dateFromate.dateFormat = "MM-dd-yyyy"
                dateShow = dateFromate.string(from: date1)
            }
            
            dateFromate = DateFormatter()
            dateFromate.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if  let date2 = dateFromate.date(from: dd) {
                dateFromate.dateFormat = "MM-dd-yyyy h:mm a"
                dateTimeShow = dateFromate.string(from: date2)
            }
            return (date: dateShow, dateTime: dateTimeShow, time: timeShow)
            
        } else {
            return (date: "", dateTime: "", time: "")
        }
        
        
    }
    
    class func getDateAndDateTime(dictH: NSDictionary, strObject: String) -> (date: String, dateTime: String, time: String) {
        let string: String = HelperClass.checkObjectInDictionaryWithNoDecimal(dictH: dictH, strObject: strObject)
        
        var dt = DateFormatter()
        dt.timeZone = TimeZone(identifier: "UTC")
        dt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let dateFromServer = dt.date(from: string) {
            
            var dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.autoupdatingCurrent
            dateFormatter.doesRelativeDateFormatting = false
            dateFormatter.dateFormat = "MMM-dd-yyyy h:mm a"
            let strDate = dateFormatter.string(from: dateFromServer)
            
            
            dateFormatter = DateFormatter()
            // dateFormatter.timeZone = TimeZone.autoupdatingCurrent
            dateFormatter.doesRelativeDateFormatting = false
            dateFormatter.dateFormat = "MMM dd, yyyy h:mm a"
            let strDateTime = dateFormatter.string(from: dateFromServer)
            
            
            dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.autoupdatingCurrent
            dateFormatter.doesRelativeDateFormatting = false
            dateFormatter.dateFormat = "h:mm a"
            let strTime = dateFormatter.string(from: dateFromServer)
            
            return (date: strDate, dateTime: strDateTime, time: strTime)
        }
        
        dt = DateFormatter()
        dt.timeZone = TimeZone(identifier: "UTC")
        dt.dateFormat = "yyyy-MM-dd hh:mm:ss"
        if let dateFromServer = dt.date(from: string) {
            var dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.autoupdatingCurrent
            dateFormatter.doesRelativeDateFormatting = false
            dateFormatter.dateFormat = "MMM d, yyyy"
            let strDate = dateFormatter.string(from: dateFromServer)
            
            dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.autoupdatingCurrent
            dateFormatter.doesRelativeDateFormatting = false
            dateFormatter.dateFormat = "MMM d, h:mm a"
            let strDateTime = dateFormatter.string(from: dateFromServer)
            
            dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.autoupdatingCurrent
            dateFormatter.doesRelativeDateFormatting = false
            dateFormatter.dateFormat = "h:mm a"
            let strTime = dateFormatter.string(from: dateFromServer)
            
            
            
            return (date: strDate, dateTime: strDateTime, time: strTime)
        }
        
        let timeinterval : TimeInterval = (string as NSString).doubleValue
        let dateFromServer = Date(timeIntervalSince1970: timeinterval)
        
        var dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.doesRelativeDateFormatting = false
        dateFormatter.dateFormat = "MMM d, yyyy"
        let strDate = dateFormatter.string(from: dateFromServer)
        
        dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.doesRelativeDateFormatting = false
        dateFormatter.dateFormat = "MMM d, h:mm a"
        let strDateTime = dateFormatter.string(from: dateFromServer)
        
        dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.doesRelativeDateFormatting = false
        dateFormatter.dateFormat = "h:mm a"
        let strTime = dateFormatter.string(from: dateFromServer)
        
        
        return (date: strDate, dateTime: strDateTime, time: strTime)
    }
    
    
    class func gateDate(dictH: NSDictionary,strDate : String) -> (String) {
        let dd = HelperClass.checkObjectInDictionaryWithNoDecimal(dictH: dictH, strObject: strDate)
        if dd != "" {
            var dateFromate = DateFormatter()
            dateFromate.dateFormat = "yyyy-MM-dd"
            if let date1 = dateFromate.date(from: dd) {
                dateFromate.dateFormat = "MMM d, yyyy"
                let dateShow = dateFromate.string(from: date1)
                return dateShow
            } else {
                dateFromate = DateFormatter()
                dateFromate.dateFormat = "yyyy-MM-dd HH:mm:ss"
                if let date1 = dateFromate.date(from: dd) {
                    dateFromate.dateFormat = "MMM d, yyyy"
                    let dateShow = dateFromate.string(from: date1)
                    return dateShow
                }
            }
            
        } else {
            return ""
        }
        
        return ""
    }
    
    class func resizeimage(with image: UIImage) -> UIImage {
        var size: CGSize = image.size
        if size.height > 512 && size.width > 512 {
            if size.height < size.width {
                let reso_width = Int((size.width - (((size.height - 512) / size.height) * size.width)))
                size = CGSize(width: CGFloat(reso_width), height: 512)
            }
            else {
                let reso_height = Int((size.height - (((size.width - 512) / size.width) * size.height)))
                size = CGSize(width: 512, height: CGFloat(reso_height))
            }
        }
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let destImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return destImage ?? UIImage()
    }
}

struct ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

class Utilities: NSObject {
    
    class func MainQueue(Completion: @escaping Variable.CompletionHandler) {
        DispatchQueue.main.async {
            Completion()
        }
    }
    
    class func DefaultPriority(Completion: @escaping Variable.CompletionHandler) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            Completion()
        }
    }
    
    class func DefaultMainQueue(Completion: @escaping Variable.CompletionHandler) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            DispatchQueue.main.async {
                Completion()
            }
        }
    }
    
    class func BackgroundQueue(Completion: @escaping Variable.CompletionHandler) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            Completion()
        }
    }
    
    class func MainBackgroundQueue(Completion: @escaping Variable.CompletionHandler) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            DispatchQueue.main.async {
                Completion()
            }
        }
    }
    
    class func Delay(delay: Double, Completion: @escaping Variable.CompletionHandler) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when) {
            Completion()
        }
    }
    
    class func AnimateWithDuration(withDuration duration: TimeInterval, Animation: @escaping Variable.Animation, Completion: @escaping Variable.CompletionHandler) {
        UIView.animate(withDuration: duration, animations: Animation) { (completed) in
            Completion()
        }
    }
    
}

public class Variable: NSObject {
    public typealias StringHandler = ((String) -> Swift.Void)
    public typealias AlertHandler = ((UIAlertAction) -> Swift.Void)
    public typealias CompletionHandler = @convention(block) () -> Swift.Void
    public typealias Connected = ((Bool) -> Swift.Void)
    public typealias Dictionary = ((NSDictionary?) -> Swift.Void)
    public typealias MapImageCompletionHandler = ((UIImage?) -> Void)?
    public typealias Animation = () -> Swift.Void
    public typealias DictionaryHandler = ((NSDictionary?) -> Swift.Void)
    public typealias ArrayHandler = ((NSArray?) -> Swift.Void)
}


class Alert: NSObject {
    
    class func SimpleAlert(message: String?, inViewController vc: UIViewController!) {
        SimpleAlert(title: nil, message: message, buttonTitle: nil, inViewController: vc)
    }
    
    class func SimpleAlert(title: String?, message: String?, inViewController vc: UIViewController!) {
        SimpleAlert(title: title, message: message, buttonTitle: nil, inViewController: vc)
    }
    
    class func SimpleAlert(title: String?, message: String?, buttonTitle: String?, inViewController vc: UIViewController!) {
        
        var strButtonTitle = "Ok"
        if buttonTitle != nil {
            strButtonTitle = buttonTitle!
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: strButtonTitle, style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func SimpleAlert(title: String?, message: String?, buttonTitle: String?, inViewController vc: UIViewController!, handler: @escaping Variable.AlertHandler) {
        
        var strButtonTitle = "Ok"
        if buttonTitle != nil {
            strButtonTitle = buttonTitle!
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: strButtonTitle, style: UIAlertAction.Style.default, handler: handler))
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func SimpleAlert(title: String?, message: String?, buttonTitle: String?, btnStyle: UIAlertAction.Style, inViewController vc: UIViewController!, handler: @escaping Variable.AlertHandler) {
        
        var strButtonTitle = "Ok"
        if buttonTitle != nil {
            strButtonTitle = buttonTitle!
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: strButtonTitle, style: btnStyle, handler: handler))
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    class func AlertWithTwoButton(message: String?, firstButtonTitle: String?, secondButtonTitle: String?, inViewController vc: UIViewController!, handler: @escaping Variable.StringHandler) {
        
        AlertWithTwoButton(title: nil, message: message, firstButtonTitle: firstButtonTitle, secondButtonTitle: secondButtonTitle, inViewController: vc, handler: handler)
        
    }
    
    class func AlertWithTwoButton(title: String?, message: String?, firstButtonTitle: String?, secondButtonTitle: String?, inViewController vc: UIViewController!, handler: @escaping Variable.StringHandler) {
        
        var strButton1Title = "Ok"
        if firstButtonTitle != nil {
            strButton1Title = firstButtonTitle!
        }
        
        var strButton2Title = "Cancel"
        if secondButtonTitle != nil {
            strButton2Title = secondButtonTitle!
        }
        
        if (strButton1Title.lowercased() == "ok" && strButton2Title.lowercased() == "cancel") {
            AlertWithArray(title: title, message: message, buttonArray: [strButton2Title, strButton1Title], inViewController: vc, handler: handler)
        } else {
            AlertWithArray(title: title, message: message, buttonArray: [strButton1Title, strButton2Title], inViewController: vc, handler: handler)
        }
        
    }
    
    class func AlertWithTwoButton(message: String?, firstButtonTitle: String?, firstButtonStyle: UIAlertAction.Style, secondButtonTitle: String?, secondButtonStyle: UIAlertAction.Style, inViewController vc: UIViewController!, handler: @escaping Variable.StringHandler) {
        
        AlertWithTwoButton(title: nil, message: message, firstButtonTitle: firstButtonTitle, firstButtonStyle: firstButtonStyle, secondButtonTitle: secondButtonTitle, secondButtonStyle: secondButtonStyle, inViewController: vc, handler: handler)
        
    }
    
    class func AlertWithTwoButton(title: String?, message: String?, firstButtonTitle: String?, firstButtonStyle: UIAlertAction.Style, secondButtonTitle: String?, secondButtonStyle: UIAlertAction.Style, inViewController vc: UIViewController!, handler: @escaping Variable.StringHandler) {
        
        var strButton1Title = "Ok"
        if firstButtonTitle != nil {
            strButton1Title = firstButtonTitle!
        }
        
        var strButton2Title = "Cancel"
        if secondButtonTitle != nil {
            strButton2Title = secondButtonTitle!
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: strButton1Title, style: firstButtonStyle, handler: { (action) in
            handler(strButton1Title)
        }))
        alert.addAction(UIAlertAction(title: strButton2Title, style: secondButtonStyle, handler: { (action) in
            handler(strButton2Title)
        }))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func AlertWithTwoButtonAndCancel(title: String?, message: String?, firstButtonTitle: String?, secondButtonTitle: String?, inViewController vc: UIViewController!, handler: @escaping Variable.StringHandler) {
        
        var strButton1Title = "Ok"
        if firstButtonTitle != nil {
            strButton1Title = firstButtonTitle!
        }
        
        var strButton2Title = "Cancel"
        if secondButtonTitle != nil {
            strButton2Title = secondButtonTitle!
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: strButton1Title, style: UIAlertAction.Style.default, handler: { (action) in
            handler(strButton1Title)
        }))
        alert.addAction(UIAlertAction(title: strButton2Title, style: UIAlertAction.Style.cancel, handler: { (action) in
            handler(strButton2Title)
        }))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func AlertWithTwoButtonAndDestructive(message: String?, firstButtonTitle: String?, secondButtonTitle: String?, inViewController vc: UIViewController!, handler: @escaping Variable.StringHandler) {
        
        AlertWithTwoButtonAndDestructive(title: nil, message: message, firstButtonTitle: firstButtonTitle, secondButtonTitle: secondButtonTitle, inViewController: vc, handler: handler)
    }
    
    class func AlertWithTwoButtonAndDestructive(title: String?, message: String?, firstButtonTitle: String?, secondButtonTitle: String?, inViewController vc: UIViewController!, handler: @escaping Variable.StringHandler) {
        
        var strButton1Title = "Ok"
        if firstButtonTitle != nil {
            strButton1Title = firstButtonTitle!
        }
        
        var strButton2Title = "Cancel"
        if secondButtonTitle != nil {
            strButton2Title = secondButtonTitle!
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: strButton1Title, style: UIAlertAction.Style.default, handler: { (action) in
            handler(strButton1Title)
        }))
        alert.addAction(UIAlertAction(title: strButton2Title, style: UIAlertAction.Style.destructive, handler: { (action) in
            handler(strButton2Title)
        }))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    class func AlertWithArray(message: String?, buttonArray arrButtons:[String]!, inViewController vc: UIViewController!, handler: @escaping Variable.StringHandler) {
        
        AlertWithArray(title: nil, message: message, buttonArray: arrButtons, inViewController: vc, handler: handler)
        
    }
    
    class func AlertWithArray(title: String?, message: String?, buttonArray arrButtons:[String]!, inViewController vc: UIViewController!, handler: @escaping Variable.StringHandler) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        for btnTitles in arrButtons {
            alert.addAction(UIAlertAction(title: btnTitles, style: UIAlertAction.Style.default, handler: { (action) in
                handler(btnTitles)
            }))
        }
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    class func AlertWithArray(message: String?, buttonArray arrButtons:[String]!, buttonStyleArray arrStyle:[UIAlertAction.Style], inViewController vc: UIViewController!, handler: @escaping Variable.StringHandler) {
        
        AlertWithArray(title: nil, message: message, buttonArray: arrButtons, buttonStyleArray: arrStyle, inViewController: vc, handler: handler)
    }
    
    class func AlertWithArray(title: String?, message: String?, buttonArray arrButtons:[String]!, buttonStyleArray arrStyle:[UIAlertAction.Style], inViewController vc: UIViewController!, handler: @escaping Variable.StringHandler) {
        
        if arrButtons.count == arrStyle.count {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            for i in 0 ..< arrButtons.count {
                alert.addAction(UIAlertAction(title: arrButtons[i], style: arrStyle[i], handler: { (action) in
                    handler(arrButtons[i])
                }))
            }
            vc.present(alert, animated: true, completion: nil)
        }
        
    }
    
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
