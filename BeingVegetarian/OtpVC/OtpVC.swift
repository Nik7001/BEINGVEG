//
//  OtpVC.swift
//  Being Vegetarian
//
//  Created by Narendra Thakur on 23/04/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit
import SVPinView
class OtpVC: UIViewController {

    var otpId = Int()
    var otpCode = Int()
    
    @IBOutlet weak var btnsubmit: UIButton!
    @IBOutlet weak var lblOtp: UILabel!
    
    
    @IBOutlet weak var viewAccess: UIView!
    @IBOutlet weak var btnViewBack: UIView!
    
    @IBOutlet weak var view2: AZHorizontalGradientView!
    @IBOutlet weak var pinView: SVPinView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //let image = UIImage(named: "logo")
        //setTitle("", andImage: image!)
        self.navigationController?.navigationBar.isHidden = false
        
        lblOtp.text = String(otpCode)
        print("otpCode",otpCode)
        print("id",otpId)
        btnViewBack.isHidden = true
        viewAccess.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        view2.setCornerRadiousAndBorder(.black, borderWidth: 0.5, cornerRadius:10)
       
        pinView.didFinishCallback = { pin in
            print("The pin entered is \(pin)")
            self.otpCode = Int(pin)!
            ///self.WS_OTP()
        }
        pinView.didChangeCallback = { pin in
      // btnsubmit.isEnabled =
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        btnViewBack.isHidden = true
        viewAccess.isHidden = true
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        let pin = pinView.getPin()
        guard !pin.isEmpty else {
            showAlert(title: "Error", message: "Pin entry incomplete")
            return
        }
           WS_OTP()
    
    }
    
    
    
    @IBAction func btnContinue(_ sender: Any) {
        btnViewBack.isHidden = true
        viewAccess.isHidden = true
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        btnViewBack.isHidden = true
        viewAccess.isHidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    //MARK:- WSservices >>>>>>>>>>>>
    func WS_OTP() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            
            var param = [String:Any]()
            
            let  strUrl = WebServicesLink.verifyOtp
            
             print("param >>>>>>>>>>\(otpCode)")
            param = [WebServiceConstant.id:otpId,WebServiceConstant.otp:otpCode]
            
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
                            self.btnViewBack.isHidden = false
                            self.viewAccess.isHidden = false
                            
                            let dict:NSMutableDictionary = json.GetNSMutableDictionary(forKey: WebServiceConstant.result)
                            print("dict >>>>>>>>>>\(dict)")
                            
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
func showAlert(title:String, message:String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
}
}
