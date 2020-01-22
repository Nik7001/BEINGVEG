//
//  ProvideFeedvbackVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 31/05/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class ProvideFeedvbackVC: UIViewController {

    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var txtDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
txtDescription.setCornerRadiousAndBorder(.clear, borderWidth:0, cornerRadius: 10)
        
    }
    
    


    @IBAction func btnFeedBack(_ sender: Any) {
        self.hideKeyBoard()
        var arrvalid = NSMutableArray()
        arrvalid = CheckValidation()
        if arrvalid.count == 0{
           WS_FeedBack()
            
        } else {
            PopUpView.addValidationView(arrvalid, strHeader: MessageStringFile.whoopsText(), strSubHeading: MessageStringFile.vInfoNeeded())
            PopUpView.sharedInstance.delegate = nil
        }
       
    }
    
    func WS_FeedBack() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            let dict = AppUserDefault.getUserDetails()
           
            print(dict)
             var param = [String:Any]()
            param = [WebServiceConstant.user_id:dict.GetInt(forKey: "id"),WebServiceConstant.title:txtTitle.text!,WebServiceConstant.message:txtDescription.text!];
            let  strUrl = WebServicesLink.feedback
            
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
                       
                            let Errormsg = json.GetString(forKey:"RESPONSE")
                                print("dict >>>>>>>>>>\(Errormsg)")
                            PopUpView.addPopUpAlertView(MessageStringFile.FeedbackText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: Errormsg, secondLblTitle: "")
                            PopUpView.sharedInstance.delegate = nil
                            
                            
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
        txtDescription.delegate = self
        txtTitle.delegate = self
       
    }
    
    //MARK:- Functions >>>>>>>>>>>>>
    func hideKeyBoard(){
        txtDescription.resignFirstResponder()
        txtTitle.resignFirstResponder()
      
    }
    //MARK:- Validation >>>>>>>>>>>>>
    func CheckValidation() -> NSMutableArray {
        let arrValidation = NSMutableArray()
        if txtTitle.text?.count == 0 {
            arrValidation.add(MessageStringFile.vtitle())
        }
        if txtDescription.text?.count == 0 {
            arrValidation.add(MessageStringFile.vmessage())
        }
        return arrValidation
    }
   
}
extension ProvideFeedvbackVC: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
extension ProvideFeedvbackVC: UITextViewDelegate {
    
    func textViewShouldReturn(textView: UITextView!) -> Bool {
        self.view.endEditing(true);
        return true;
    }
   
}
