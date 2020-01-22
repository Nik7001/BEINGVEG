//
//  AppColor.swift
//  Trunks
//
//  Created by Nitin Saklecha on 05/09/18.
//  Copyright © 2018 Arnasoftech. All rights reserved.
//

import UIKit
let appDelegate = UIApplication.shared.delegate as! AppDelegate
class AppColor: NSObject {
    // Font Color
    static let bgColor = UIColor.init(hexString: "#efefef")//BackGround Color
    static let btnColor = UIColor.init(hexString: "#017aa7")//Orenge Button Collor
    static let headerColor = UIColor.init(hexString: "#efefef")
    static let cardColor = UIColor.init(hexString: "#1f1f1f")
    static let fieldColor = UIColor.init(hexString: "#017aa7")//Field Color
    static let dividerColor = UIColor.init(hexString: "#2e3238")
    static let  grayheadingbgcolour = UIColor.init(hexString: "#1f1f1f")
    static let  fontcolour = UIColor.init(hexString: "#151515")
    static let  btnlogincolour = UIColor.init(hexString: "#017aa7")
    static let  graybtncolour = UIColor.init(hexString: "#292929")
    static let   ratinggreenbgColour = UIColor.init(hexString: "#0ca100")
    static let   SchedulepagebookColour = UIColor.init(hexString: "#606060")
    
  //  booking screen
    
  /*  book:-3ebe0c
    confirm:-e33d7b
    out for service:-6c41f7
    on service:- 00c2f3
    completed:-ee7f21
    cancelled:-ef1c1c
    notificaton delete bg:-f32542*/
    
    //Statistics screen
    
    
    /*completed:-8a40af
    cancelled:-4878c0
    pending:-3ea3ab*/
    
    
  //  Notification circle colour code
    static let appPendingColor = UIColor(hexString: "#cbb7e7")
    static let appAcceptedColor = UIColor(hexString: "#664c8e")
    static let appAssignColor = UIColor(hexString: "#32a7d5")
    static let appOnDeliveryColor = UIColor(hexString: "#7775a9")
    static let appCompletedColor = UIColor(hexString: "#9a45c7")
    static let appCancelledColor = UIColor(hexString: "#4b7dc7")
 
    
    
    
}



class AppFunction: NSObject {
    
    class func indexOfInt(id: Int ,arrMutable : NSMutableArray,strSearchKey : String) -> Int {
        let arrNS = arrMutable.mutableCopy() as! NSArray
        let arr = arrNS.mutableCopy() as! [[String:Any]]
        return arr.index { (dict) -> Bool in
            return dict[strSearchKey] as? Int == id
            } ?? NSNotFound
    }
    
    class func indexOfString(str: String ,arrMutable : NSMutableArray,strSearchKey : String) -> Int {
        let arrNS = arrMutable.mutableCopy() as! NSArray
        let arr = arrNS.mutableCopy() as! [[String:Any]]
        return arr.index { (dict) -> Bool in
            return dict[strSearchKey] as? String == str
            } ?? NSNotFound
    }
    
    class func arrFromArr(value: String ,arrMutable : NSMutableArray,strSearchKey : String) -> NSMutableArray {
        let Predicate : NSPredicate = NSPredicate(format: "SELF.\(strSearchKey) like %@",value)
        let arrMainMutable = arrMutable.filtered(using: Predicate) as NSArray
        return arrMainMutable.mutableCopy() as! NSMutableArray
    }
    
    class func arrFromArr(value: Int ,arrMutable : NSMutableArray,strSearchKey : String) -> NSMutableArray {
        let Predicate : NSPredicate = NSPredicate(format: "SELF.\(strSearchKey) == \(value)")
        let arrMainMutable = arrMutable.filtered(using: Predicate) as NSArray
        return arrMainMutable.mutableCopy() as! NSMutableArray
    }
    
}
