//
//  WebSeviceConstant.swift
//  Trunks
//
//  Created by Nitin Saklecha on 05/09/18.
//  Copyright © 2018 Arnasoftech. All rights reserved.
//
import Foundation
import UIKit

class WebServicesLink: NSObject {
    
    static let  BaseUrl = "http://being.easyeducation.in/webservice.php?action="
    
    
  //http://being.easyeducation.in/webservice.php?action=login&email=t@gmail.com&password=123456
    
    class var baseUrl: String {
        get {
            if let dict = UserDefaults.standard.dictionary(forKey: AppUserDefault.baseUrlData) {
                let dictData = dict as NSDictionary
                let baseUrl = dictData.GetString(forKey: "baseurl")
                if baseUrl.Length > 0 {
                    return baseUrl
                }
            }
            return WebServicesLink.BaseUrl.replacingOccurrences(of: "baseurl", with: "")
        }
    }
    
    func getToken() -> [String: AnyObject]{
        let dict : NSDictionary = AppUserDefault.getUserDetails()//
        let tkn  = HelperClass.checkObjectInDictionary(dictH: dict, strObject: "token")
        if tkn != ""{
           
            let header = ["token": tkn]
            // "content_type":"application/x-www-form-urlencoded"
            return header as [String : AnyObject]
        }
        return  [ : ]
    }
    
    func getProfileImage()-> String{
        var imgStr = String()
        let dict:NSDictionary = AppUserDefault.getBaseUrlData()!
        
        imgStr = dict.GetString(forKey:  "picture")
        return imgStr
    }
    
    class var getCountry: String {
        get {
            return (baseUrl + "countrylist")
        }
    }
    
    class var registration: String {
        get {
            return (baseUrl + "user_register&")
        }
    }
    
    
    class var login: String {
        get {
            return (baseUrl + "login&")
        }
    }
    
    class var verifyOtp: String {
        get {
            return (baseUrl + "validate_otp&")
        }
    }
    
    class var bannerList: String {
        get {
            return (baseUrl + "bannerlist")
        }
    }
    
    class var restaurant_banner: String {
        get {
            return (baseUrl + "restaurant_banner")
        }
    }
    
    class var myrestaurant: String {
        get {
            return (baseUrl + "myrestaurant")
        }
    }
    class var cuisines_list: String {
        get {
            return (baseUrl + "cuisines_list")
        }
    }
    
    
    
    class var ForgotPassword: String {
        get {
         return (baseUrl + "api/ForgetPassword")
        }
    }
    class var restorent_register: String {
        get {
            return (baseUrl + "resto_register&")
        }
    }
    
    class var upcomingEvent: String {
        get {
            return (baseUrl + "upcommingevents")
        }
    }
    class var favouriteEvent: String {
        get {
            return (baseUrl + "favourite_event&")
        }
    }
    class var EventDetails: String {
        get {
            return (baseUrl + "eventdetail&")
        }
    }
    class var addtofavorite: String {
        get {
            return (baseUrl + "addtofavorite&")
        }
    }
    class var removefromfavorite: String {
        get {
            return (baseUrl + "removefromfavorite&")
        }
    }
    class var gallerylist: String {
        get {
            return (baseUrl + "gallerylist")
        }
    }
    class var eventBooking: String {
        get {
            return (baseUrl + "event_booking&")
        }
    }
    class var feedback: String {
        get {
            return (baseUrl + "feedback&")
        }
    }
    
    class var top_restaurants: String {
        get {
            return (baseUrl + "top_restaurants")
        }
    }
    class var restaurantname_alphabetically: String {
        get {
            return (baseUrl + "restaurantname_alphabetically")
        }
    }
    class var cuisines_categorylist: String {
        get {
            return (baseUrl + "cuisines_categorylist")
        }
    }
    class var restaurantlist: String {
        get {
            return (baseUrl + "restaurantlist")
        }
    }
    
   
    }
class WebServiceConstant: NSObject {
    static let status = "RESPONSECODE"
    static let Error =   0
    static let success =  1
    static let msg = "Message"
    static let result = "RESPONSE"
    static let baseurl = "base_url"
    static let countryid = "country_id"
    static let firstname = "first_name"
    static let lastname = "last_name"
    static let phonecode = "phonecode"
    static let mobile = "mobile"
    static let email = "email"
    static let password = "password"
    static let id = "id"
    static let otp = "otp"
    static let name = "name"
    static let address = "address"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let addressID    = "addressID"
    static let productID = "productID"
    static let cuisines_offer = "cuisines_offer"
    static let user_id = "user_id"
    static let openning_time = "openning_time"
    static let closing_time = "closing_time"
    static let description = "description"
    static let image = "image"
    static let area = "area"
    static let subscription = "subscription"
    static let event_id = "event_id"
     static let guest = "guest"
 static let eventprice = "eventprice"
 static let eventguest = "eventguest"
    static let location = "location"
     static let title = "title"
      static let message = "message"


    
    
    
    
    
    //Jdata_dod
    static let device_type = "device"
    static let DeviceToken = "DeviceToken"
    static let app_version = "app_version"
    static let os_version = "os_version"
    static let network_type = "network_type"
    static let network_provider = "network_provider"
    
    
   
    
}

struct WS_Status {
    static let success:  UInt = 200
    static let error204: UInt = 204
    static let error401: UInt = 401
    static let error422: UInt = 422
}

