//
//  eVentDetailVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 30/05/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class eVentDetailVC: UIViewController {
var restID = Int()
 var UserID = Int()
    var EventDetails = NSMutableDictionary()
    
    
    @IBOutlet weak var btnStar: UIButton!
    
    @IBOutlet weak var lblEventName: UILabel!
    
    @IBOutlet weak var lblStartEvent: UILabel!
    
    @IBOutlet weak var eventImg: UIImageView!
    
    @IBOutlet weak var lblEndEvent: UILabel!
    
    @IBOutlet weak var lblCoast: UILabel!
    
    @IBOutlet weak var lblVenue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        WS_EventDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let image = UIImage(named: "logo")
        setTitle("", andImage: image!)
    }
    //MARK:- WSservices >>>>>>>>>>>>
    func WS_EventDetails() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            let dict = AppUserDefault.getUserDetails()
            UserID = dict.GetInt(forKey: "id")
             var param = [String:Any]()
            param = [WebServiceConstant.event_id:restID,WebServiceConstant.user_id:UserID];
            let  strUrl = WebServicesLink.EventDetails
            
            // print("param >>>>>>>>>>\(param)")
            print("param >>>>>>>>>>\(strUrl)")
            
            WebService.createRequestAndGetResponse(strUrl, methodType: .GET, andHeaderDict:[:], andParameterDict: param, onCompletion: { (dictResponse,error,reply,statusCode) in
                print("dictResponse >>>\(String(describing: dictResponse))")
                print("error >>>\(String(describing: error))")
                print("reply >>>\(String(describing: reply))")
                print("statuscode >>>\(String(describing: statusCode))")
                SwiftLoader.hide()
                let json = dictResponse! as[String: Any] as NSDictionary
                
                print("json>>>>\(json)")
                SwiftLoader.hide()
                var msg = ""
                msg = json.GetString(forKey: WebServiceConstant.msg)
                if msg == "" {
                    msg = MessageStringFile.serverError()
                }
                if json.count > 0 {
                    
                    if statusCode == WS_Status.success {
                        if json.GetInt(forKey:"RESPONSECODE") == 1 {
                            
                            self.EventDetails = json.GetNSMutableDictionary(forKey: "RESPONSE")
                        AppUserDefault.seteventDetailas(dict:self.EventDetails)
                            self.lblEventName.text = self.EventDetails.GetString(forKey: "name")
                            self.lblStartEvent.text = self.EventDetails.GetString(forKey: "start_time")
                            self.lblEndEvent.text = self.EventDetails.GetString(forKey: "end_time")
                            self.lblCoast.text = "$" + "\(self.EventDetails.GetInt(forKey: "cost"))" + "/" + "\(self.EventDetails.GetInt(forKey: "no_of_guest"))" + " " + "person"
                            self.lblVenue.text = self.EventDetails.GetString(forKey: "address")
                            let urlstring = self.EventDetails.GetString(forKey: "image")
                            self.eventImg.sd_setImage(with: URL(string:urlstring), placeholderImage: UIImage(named: "1"))
                            if self.EventDetails.GetInt(forKey:"favorite") == 1{
                                self.btnStar.setImage(UIImage(named: "StarFull"), for: .normal)
                            }else{
                            self.btnStar.setImage(UIImage(named: "star"), for: .normal)
                            }
                            
                          
                            
                        } else if json.GetInt(forKey:"RESPONSECODE") == 0 {
                            let Errormsg = json.GetString(forKey:"RESPONSE")
                            print("dict >>>>>>>>>>\(Errormsg)")
                            PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: Errormsg, secondLblTitle: "")
                            PopUpView.sharedInstance.delegate = nil
                            
                        } else {
                            PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: msg, secondLblTitle: "")
                            PopUpView.sharedInstance.delegate = nil
                        }
                    } else {
                        PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: msg, secondLblTitle: "")
                        PopUpView.sharedInstance.delegate = nil
                    }
                } else {
                    PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: msg, secondLblTitle: "")
                    PopUpView.sharedInstance.delegate = nil
                }
            })
        } else {
            PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle:MessageStringFile.okText() , rightBtnTitle:"" , firstLblTitle: MessageStringFile.networkReachability(), secondLblTitle: "")
            PopUpView.sharedInstance.delegate = nil
        }
    }

    @IBAction func btnFavrate(_ sender: Any) {
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
                button.setImage(UIImage(named: "StarEmpty"), for: .normal)
                 WS_removeFavarate()
            } else {
               
                WS_AddFavrate()
                button.setImage(UIImage(named: "StarFull"), for: .selected)

                button.isSelected = true
            }
        }
    }
    
    
    //MARK:- WSservices >>>>>>>>>>>>
    func WS_AddFavrate() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            let dict = AppUserDefault.getUserDetails()
            UserID = dict.GetInt(forKey: "id")
            var param = [String:Any]()
            param = [WebServiceConstant.event_id:restID,WebServiceConstant.user_id:UserID];
            let  strUrl = WebServicesLink.addtofavorite
            
            // print("param >>>>>>>>>>\(param)")
            print("param >>>>>>>>>>\(strUrl)")
            
            WebService.createRequestAndGetResponse(strUrl, methodType: .GET, andHeaderDict:[:], andParameterDict: param, onCompletion: { (dictResponse,error,reply,statusCode) in
                print("dictResponse >>>\(String(describing: dictResponse))")
                print("error >>>\(String(describing: error))")
                print("reply >>>\(String(describing: reply))")
                print("statuscode >>>\(String(describing: statusCode))")
                SwiftLoader.hide()
                let json = dictResponse! as[String: Any] as NSDictionary
                
                print("json>>>>\(json)")
                SwiftLoader.hide()
                var msg = ""
                msg = json.GetString(forKey: WebServiceConstant.msg)
                if msg == "" {
                    msg = MessageStringFile.serverError()
                }
                if json.count > 0 {
                    
                    if statusCode == WS_Status.success {
                        if json.GetInt(forKey:"RESPONSECODE") == 1 {
                            
                          let Errormsg = json.GetString(forKey:"RESPONSE")
                        PopUpView.addPopUpAlertView(MessageStringFile.SuccessText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: Errormsg, secondLblTitle: "")
                        } else if json.GetInt(forKey:"RESPONSECODE") == 0 {
                            let Errormsg = json.GetString(forKey:"RESPONSE")
                            print("dict >>>>>>>>>>\(Errormsg)")
                            PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: Errormsg, secondLblTitle: "")
                            PopUpView.sharedInstance.delegate = nil
                            
                        } else {
                            PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: msg, secondLblTitle: "")
                            PopUpView.sharedInstance.delegate = nil
                        }
                    } else {
                        PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: msg, secondLblTitle: "")
                        PopUpView.sharedInstance.delegate = nil
                    }
                } else {
                    PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: msg, secondLblTitle: "")
                    PopUpView.sharedInstance.delegate = nil
                }
            })
        } else {
            PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle:MessageStringFile.okText() , rightBtnTitle:"" , firstLblTitle: MessageStringFile.networkReachability(), secondLblTitle: "")
            PopUpView.sharedInstance.delegate = nil
        }
    }
    
    
    func WS_removeFavarate() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            let dict = AppUserDefault.getUserDetails()
            UserID = dict.GetInt(forKey: "id")
            var param = [String:Any]()
            param = [WebServiceConstant.event_id:restID,WebServiceConstant.user_id:UserID];
            let  strUrl = WebServicesLink.removefromfavorite
            
            // print("param >>>>>>>>>>\(param)")
            print("param >>>>>>>>>>\(strUrl)")
            
            WebService.createRequestAndGetResponse(strUrl, methodType: .GET, andHeaderDict:[:], andParameterDict: param, onCompletion: { (dictResponse,error,reply,statusCode) in
                print("dictResponse >>>\(String(describing: dictResponse))")
                print("error >>>\(String(describing: error))")
                print("reply >>>\(String(describing: reply))")
                print("statuscode >>>\(String(describing: statusCode))")
                SwiftLoader.hide()
                let json = dictResponse! as[String: Any] as NSDictionary
                
                print("json>>>>\(json)")
                SwiftLoader.hide()
                var msg = ""
                msg = json.GetString(forKey: WebServiceConstant.msg)
                if msg == "" {
                    msg = MessageStringFile.serverError()
                }
                if json.count > 0 {
                    
                    if statusCode == WS_Status.success {
                        if json.GetInt(forKey:"RESPONSECODE") == 1 {
                            
                            let Errormsg = json.GetString(forKey:"RESPONSE")
                            PopUpView.addPopUpAlertView(MessageStringFile.removeText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: Errormsg, secondLblTitle: "")
                        } else if json.GetInt(forKey:"RESPONSECODE") == 0 {
                            let Errormsg = json.GetString(forKey:"RESPONSE")
                            print("dict >>>>>>>>>>\(Errormsg)")
                            PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: Errormsg, secondLblTitle: "")
                            PopUpView.sharedInstance.delegate = nil
                            
                        } else {
                            PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: msg, secondLblTitle: "")
                            PopUpView.sharedInstance.delegate = nil
                        }
                    } else {
                        PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: msg, secondLblTitle: "")
                        PopUpView.sharedInstance.delegate = nil
                    }
                } else {
                    PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: msg, secondLblTitle: "")
                    PopUpView.sharedInstance.delegate = nil
                }
            })
        } else {
            PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle:MessageStringFile.okText() , rightBtnTitle:"" , firstLblTitle: MessageStringFile.networkReachability(), secondLblTitle: "")
            PopUpView.sharedInstance.delegate = nil
        }
    }
    
    
    @IBAction func btnShare(_ sender: Any) {
          let dict = AppUserDefault.getUserDetails()
           let name = dict.GetString(forKey: "first_name")
        let textToShare = "Your Friend:" + name + "," + "have shared an events details with you, having" + lblEventName.text!  + lblStartEvent.text! + lblEndEvent.text! + lblCoast.text! + lblVenue.text!
        
        if let myWebsite = NSURL(string: "http://www.google.com/") {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            //
            activityVC.popoverPresentationController?.sourceView = sender as? UIView
            self.present(activityVC, animated: true, completion: nil)
      }
    }
    
    @IBAction func btnRegisterNow(_ sender: Any) {
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "EventRegisterVC") as! EventRegisterVC
        VC.EventDetail = EventDetails
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
