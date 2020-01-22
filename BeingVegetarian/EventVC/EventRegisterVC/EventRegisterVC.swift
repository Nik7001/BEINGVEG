//
//  EventRegisterVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 30/05/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class EventRegisterVC: UIViewController,CountryDelegate {

    var EventDetail = NSMutableDictionary()
    var countryName = String()
    var phoneCode   = String()
    var CountryId   = String()
    func valueLable(countryData: NSDictionary) {
        print("countryData",countryData)
        phoneCode = String(countryData.GetInt(forKey: "phonecode"))
        countryName = countryData.GetString(forKey: "country_name")
        CountryId = countryData.GetString(forKey: "country_id")
        
        //txtCountryCode.text = "+" + phoneCode
        txtSelectCountry.text = countryName
        
    }
    
    @IBOutlet weak var lblEventName: UILabel!
    
    @IBOutlet weak var lblVenue: UILabel!
    
    
    @IBOutlet weak var lblCost: UILabel!
    
    
    @IBOutlet weak var txtSelectCountry: UITextField!
    
    @IBOutlet weak var txtFirstName: UITextField!
    
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtMobile: UITextField!
    
    @IBOutlet weak var txtAdd: UITextField!
    
    @IBOutlet weak var txtguest: UITextField!
    
    @IBOutlet weak var btnRewardPoint: UIButton!
    
    
    @IBOutlet weak var lblTotalPoint: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let dict = AppUserDefault.getUserDetails()
        txtFirstName.text = dict.GetString(forKey: "first_name")
        txtLastName.text = dict.GetString(forKey: "last_name")
        txtEmail.text = dict.GetString(forKey: "email")
        txtMobile.text = dict.GetString(forKey: "mobile_no")
        
         let dictevent = AppUserDefault.geteventDetails()
        
        lblVenue.text = dictevent.GetString(forKey: "address")
        
        lblEventName.text = dictevent.GetString(forKey: "name")
        lblCost.text = "$" + "\(dictevent.GetInt(forKey: "cost"))" + "/" + "\(dictevent.GetInt(forKey: "no_of_guest"))" + " " + "person"
        
        //txtSelectCountry.text = "+" + phoneCode
        txtSelectCountry.text = countryName

      
      

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let image = UIImage(named: "logo")
        setTitle("", andImage: image!)
    }
    
    
    @IBAction func btnCountry(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "CountryVC") as! CountryVC
        VC.delegate = self
        // let navigationVC = UINavigationController(rootViewController: VC)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnBookNow(_ sender: Any) {
        self.hideKeyBoard()
        var arrvalid = NSMutableArray()
        arrvalid = CheckValidation()
        if arrvalid.count == 0{
            WS_Book()
            
        } else {
            PopUpView.addValidationView(arrvalid, strHeader: MessageStringFile.whoopsText(), strSubHeading: MessageStringFile.vInfoNeeded())
            PopUpView.sharedInstance.delegate = nil
        }
    }
    

    @IBAction func btnRewards(_ sender: Any) {
    }
    
    func WS_Book() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            
            var param = [String:Any]()
            
            let  strUrl = WebServicesLink.eventBooking
          
            param = [WebServiceConstant.event_id:"",WebServiceConstant.user_id:"",WebServiceConstant.name:txtFirstName.text!,WebServiceConstant.email:txtEmail.text!,WebServiceConstant.email:txtEmail.text!,WebServiceConstant.address:txtAdd.text!,WebServiceConstant.location:"",WebServiceConstant.guest:txtAdd.text!,WebServiceConstant.eventprice:"",WebServiceConstant.eventguest:""]
            
            
            print("param >>>>>>>>>>\(param)")
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
                            
                            let dict:NSMutableDictionary = json.GetNSMutableDictionary(forKey: WebServiceConstant.result)
                            print("dict >>>>>>>>>>\(dict)")
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                            vc.otpCode =  json.GetInt(forKey:"RESPONSE");
                            vc.otpId =  json.GetInt(forKey:"RESPONSEID");
                            
                            self.navigationController?.pushViewController(vc, animated: false)
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
    
    //MARK:- setDelegate >>>>>>>>>>>>>
    func setDelegate() {
        txtEmail.delegate = self
        txtMobile.delegate = self
        txtLastName.delegate = self
        txtFirstName.delegate = self
        txtSelectCountry.delegate = self
        txtguest.delegate = self
        txtAdd.delegate = self
        
    }
    
    //MARK:- Functions >>>>>>>>>>>>>
    func hideKeyBoard(){
        txtEmail.resignFirstResponder()
        txtMobile.resignFirstResponder()
        txtAdd.resignFirstResponder()
        txtSelectCountry.resignFirstResponder()
        txtLastName.resignFirstResponder()
        txtFirstName.resignFirstResponder()
        txtguest.resignFirstResponder()
    }
    //MARK:- Validation >>>>>>>>>>>>>
    func CheckValidation() -> NSMutableArray {
        let arrValidation = NSMutableArray()
        if txtEmail.text?.count == 0 {
            arrValidation.add(MessageStringFile.vEmail())
        }
        if txtFirstName.text?.count == 0 {
            arrValidation.add(MessageStringFile.vFirstName())
        }
        if txtMobile.text?.count == 0 {
            arrValidation.add(MessageStringFile.vValidMobile())
        }
        if txtLastName.text?.count == 0 {
            arrValidation.add(MessageStringFile.vLastName())
        }
    if txtAdd.text?.count == 0 {
            arrValidation.add(MessageStringFile.vAddress())
        }
        if txtguest.text?.count == 0 {
            arrValidation.add(MessageStringFile.vguest())
        }
        if txtSelectCountry.text?.count == 0 {
            arrValidation.add(MessageStringFile.vselectContry())
        }
        if !ValidationsFile.isValidEmail(strEmail: txtEmail.text!) {
            if txtEmail.text!.count > 0{
                arrValidation.add (MessageStringFile.vValidEmail())
            }
        }
      
        return arrValidation
    }
}

extension EventRegisterVC: UITextFieldDelegate {
        
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            return true
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


