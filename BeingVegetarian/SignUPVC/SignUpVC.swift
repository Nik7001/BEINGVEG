//
//  SignUpVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 24/05/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController,CountryDelegate {
    
    var countryName = String()
    var phoneCode   = String()
    var CountryId   = String()
    
    func valueLable(countryData: NSDictionary) {
        print("countryData",countryData)
        phoneCode = String(countryData.GetInt(forKey: "phonecode"))
        countryName = countryData.GetString(forKey: "country_name")
        CountryId = countryData.GetString(forKey: "country_id")
        
        txtCountryCode.text = "+" + phoneCode
        txtCountry.text = countryName
        
    }
   
    

    @IBOutlet weak var txtCountry: UITextField!
    
    @IBOutlet weak var txtCountryCode: UITextField!
    
    
    
    @IBOutlet weak var txtFirstName: UITextField!
    
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var btnCountry: UIButton!
    
    @IBOutlet weak var txtMobile: UITextField!
    
    @IBOutlet weak var txtPasswrd: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtConfirmP: UITextField!
    
    @IBOutlet weak var btnTermCondition: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
      txtFirstName.setCornerRadiousAndBorder(.black, borderWidth: 0.5, cornerRadius:10)
      txtLastName.setCornerRadiousAndBorder(.black, borderWidth: 0.5, cornerRadius:10)
     txtMobile.setCornerRadiousAndBorder(.black, borderWidth: 0.5, cornerRadius:10)
     txtPasswrd.setCornerRadiousAndBorder(.black, borderWidth: 0.5, cornerRadius:10)
    txtConfirmP.setCornerRadiousAndBorder(.black, borderWidth: 0.5, cornerRadius:10)
    txtCountry.setCornerRadiousAndBorder(.black, borderWidth: 0.5, cornerRadius:10)
    txtEmail.setCornerRadiousAndBorder(.black, borderWidth: 0.5, cornerRadius:10)
    txtCountryCode.setCornerRadiousAndBorder(.black, borderWidth: 0.5, cornerRadius:10)
        
       
       
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

    }
    
    
    
    @IBAction func btnCountry(_ sender: Any) {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "CountryVC") as! CountryVC
        VC.veryfySignup = "1"
        VC.delegate = self
       // let navigationVC = UINavigationController(rootViewController: VC)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnTerm(_ sender: Any) {
        
        if (btnTermCondition.isSelected ==  true) {
            btnTermCondition.isSelected = false;
            let image = UIImage(named: "unchecked")
                btnTermCondition.setImage(image, for: .normal)
        }else {
            btnTermCondition.isSelected = true;
            let image = UIImage(named: "check")
            btnTermCondition.setImage(image, for: .normal)
        }
    }
    
    @IBAction func btnRegistration(_ sender: Any) {
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
//        //vc.otpCode = dict.GetString(forKey:"RESPONSE");
//       // vc.otpId = dict.GetString(forKey:"RESPONSEID");
//        
//        self.navigationController?.pushViewController(vc, animated: false)
        self.hideKeyBoard()
        var arrvalid = NSMutableArray()
        arrvalid = CheckValidation()
        if arrvalid.count == 0{
            WS_SignUp()

        } else {
            PopUpView.addValidationView(arrvalid, strHeader: MessageStringFile.whoopsText(), strSubHeading: MessageStringFile.vInfoNeeded())
            PopUpView.sharedInstance.delegate = nil
        }
    }
    
    //MARK:- WSservices >>>>>>>>>>>>
    func WS_SignUp() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            
            var param = [String:Any]()
            
              let  strUrl = WebServicesLink.registration
            
            param = [WebServiceConstant.countryid:CountryId,WebServiceConstant.firstname:txtFirstName.text!,WebServiceConstant.lastname:txtLastName.text!,WebServiceConstant.phonecode:phoneCode,WebServiceConstant.mobile:txtMobile.text!,WebServiceConstant.email:txtEmail.text!,WebServiceConstant.password:txtPasswrd.text!]
          
        
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
        txtPasswrd.delegate = self
        txtMobile.delegate = self
        txtLastName.delegate = self
        txtFirstName.delegate = self
        txtPasswrd.delegate = self
        txtConfirmP.delegate = self
    }
    
    //MARK:- Functions >>>>>>>>>>>>>
    func hideKeyBoard(){
        txtEmail.resignFirstResponder()
        txtMobile.resignFirstResponder()
        txtCountry.resignFirstResponder()
        txtPasswrd.resignFirstResponder()
        txtLastName.resignFirstResponder()
        txtFirstName.resignFirstResponder()
        txtConfirmP.resignFirstResponder()
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
        if txtCountry.text?.count == 0 {
            arrValidation.add(MessageStringFile.vselectContry())
        }
        if !ValidationsFile.isValidEmail(strEmail: txtEmail.text!) {
            if txtEmail.text!.count > 0{
                arrValidation.add (MessageStringFile.vValidEmail())
            }
        }
        if txtPasswrd.text?.count == 0 {
            arrValidation.add(MessageStringFile.vPassword())
        }
        if txtPasswrd.text?.count != 0 {
            if (txtPasswrd.text!.count) < 6 {
                arrValidation.add(MessageStringFile.vPasswordLength())
            }
        }
        if(txtPasswrd.text != self.txtConfirmP.text){
            arrValidation.add(MessageStringFile.vPasswordAndConfirmPasswordNotMatch())
        }
        
        if (btnTermCondition.isSelected ==  false) {
          
            let image = UIImage(named: "unchecked")
            btnTermCondition.setImage(image, for: .normal)
            arrValidation.add(MessageStringFile.VTermsCondititons())
        }
        return arrValidation
    }
    
   
    
}
extension SignUpVC: UITextFieldDelegate {
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
