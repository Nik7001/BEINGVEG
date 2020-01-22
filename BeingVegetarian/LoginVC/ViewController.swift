//
//  ViewController.swift
//  Being Vegetarian
//
//  Created by Narendra Thakur on 15/04/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

     var isRemember:Bool = false
    
   // @IBOutlet weak var rememberBtn: UIButton!
    
    
    @IBOutlet weak var facebook: UIButton!
    
    @IBOutlet weak var google: UIButton!
    @IBOutlet weak var twitter: UIButton!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
         self.navigationController?.navigationBar.isHidden = true
       // let image = UIImage(named: "logo")
       // setTitle("BEING VEGETARIAN", andImage: image!)
        facebook.setCornerRadiousAndBorder(.black, borderWidth: 0.5, cornerRadius:10)
        twitter.setCornerRadiousAndBorder(.black, borderWidth: 0.5, cornerRadius:10)
        google.setCornerRadiousAndBorder(.black, borderWidth: 0.5, cornerRadius:10)
        txtEmail.setCornerRadiousAndBorder(.black, borderWidth: 0.5, cornerRadius:10)
        txtPassword.setCornerRadiousAndBorder(.black, borderWidth: 0.5, cornerRadius:10)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rememberMe()
        if AppUserDefault.isUserLogin {
            let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            let leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
            let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
            leftViewController.homevc = nvc
            let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
            slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
            UIApplication.shared.delegate?.window??.rootViewController = slideMenuController
        }
    }
    
    @IBAction func btnRemember(_ sender: Any) {
        hideKeyBoard()
        setRememberMeImage()
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        
        self.hideKeyBoard()
        var arrvalid = NSMutableArray()
        arrvalid = CheckValidation()
        if arrvalid.count == 0{
            WS_Login()
            
        } else {
            PopUpView.addValidationView(arrvalid, strHeader: MessageStringFile.whoopsText(), strSubHeading: MessageStringFile.vInfoNeeded())
            PopUpView.sharedInstance.delegate = nil
        }
        
        
      
    }
    
    @IBAction func btnForget(_ sender: Any) {
    }
    
    @IBAction func btnFacebook(_ sender: Any) {
    }
    
    @IBAction func btnTwitter(_ sender: Any) {
    }
    
    @IBAction func btnGoogle(_ sender: Any) {
    }
    
    
    
    func rememberMe(){ //For Check Remember or not >>>>>>>
        if AppUserDefault.getEmailPassword().isRemember == true{
            self.isRemember = true
            self.txtEmail.text = AppUserDefault.getEmailPassword().email
            self.txtPassword.text = AppUserDefault.getEmailPassword().password
            let image = UIImage(named: "check")
            //rememberBtn.setImage(image, for: .normal)
            
            
        }else{
            self.isRemember = false
            self.txtEmail.text = ""
            self.txtPassword.text = ""
            let image = UIImage(named: "unselect")
            //rememberBtn.setImage(image, for: .normal)
        }
    }
    
    func setDefaultEmailPass(){ // Save Email or PassWord  >>>>>
        let userDefaults = UserDefaults.standard
        if self.isRemember == false{
            AppUserDefault.setEmailPasswordInUserDefaults(email: "", password: "",isRemember: false)
            userDefaults.removeObject(forKey: AppUserDefault.isRemember)
        }else{
            AppUserDefault.setEmailPasswordInUserDefaults(email: txtEmail.text!, password: txtPassword.text!,isRemember: true)
            userDefaults.set(true, forKey: AppUserDefault.isRemember)
        }
    }
    
    
    
      //MARK:- setRememberMeImage >>>>>>>>>>>>>
    
    func setRememberMeImage(){
        
        if isRemember {
            isRemember = false
            let image = UIImage(named: "unselect")
           // rememberBtn.setImage(image, for: .normal)
        } else {
            isRemember = true
            let image = UIImage(named: "check")
           // rememberBtn.setImage(image, for: .normal)
        }
    }
    
    
    
    func setDelegate() {
        txtEmail.delegate = self
        txtPassword.delegate = self
    }
    //MARK:- Functions >>>>>>>>>>>>>
    func hideKeyBoard(){
        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
    }
    //MARK:- Validation >>>>>>>>>>>>>
    func CheckValidation() -> NSMutableArray {
        let arrValidation = NSMutableArray()
        
//        if !ValidationsFile.isValidEmail(strEmail: txtEmail.text!) {
//            if txtEmail.text!.count > 0{
//                arrValidation.add (MessageStringFile.vValidEmail())
//            }
//        }
        
        if txtEmail.text?.count == 0 {
            arrValidation.add(MessageStringFile.vEmail())
        }
        if txtPassword.text?.count == 0 {
            arrValidation.add(MessageStringFile.vPassword())
        }
        
        return arrValidation
    }
    
    //Func WebServices
    
    func WS_Login() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            
            let strUrl = WebServicesLink.login
            var param = [String:Any]()
            
            param = [WebServiceConstant.email:txtEmail.text!,WebServiceConstant.password:txtPassword.text!]
            
            print("param >>>>>>>>>>\(param)")
            print("param >>>>>>>>>>\(strUrl)")
            
            WebService.createRequestAndGetResponse(strUrl, methodType: .GET, andHeaderDict:[:], andParameterDict: param, onCompletion: { (dictResponse,error,reply,statusCode) in
                SwiftLoader.hide()
                print("dictResponse >>>\(String(describing: dictResponse))")
                print("error >>>\(String(describing: error))")
                print("reply >>>\(String(describing: reply))")
                print("statuscode >>>\(String(describing: statusCode))")
                
                let json = dictResponse! as[String: Any] as NSDictionary
                print("json>>>>\(json)")
                
                var msg = ""
                msg = json.GetString(forKey: WebServiceConstant.msg)
                if msg == "" {
                    msg = MessageStringFile.serverError()
                }
                SwiftLoader.hide()
                if json.count > 0 {
                    
                    if statusCode == WS_Status.success {
                        if json.GetInt(forKey:"RESPONSECODE") == 1 {
                            
                            let dict:NSMutableDictionary = json.GetNSMutableDictionary(forKey: WebServiceConstant.result)
                            print("dict >>>>>>>>>>\(dict)")
                            
                           
                    self.setDefaultEmailPass()
                            AppUserDefault.setUserDetails(dict: dict)
                        AppUserDefault.setUserLoginStatus(status: 1)
                            
                            let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                            let leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
                            let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
                            leftViewController.homevc = nvc
                            let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
                            slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
                            UIApplication.shared.delegate?.window??.rootViewController = slideMenuController
                    
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
    
    
    

}
extension ViewController: UITextFieldDelegate {
    
    //MARK:- Textfield delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtEmail  {
            if (txtEmail.text?.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty)! && string == " " {
                return false
            }
            else {
                let charcterSet  = NSCharacterSet(charactersIn: ValidationsFile.emailAcceptableCharacter).inverted
                let inputString = string.components(separatedBy: charcterSet)
                if inputString.count == 1 {
                    let newLength: Int = textField.text!.count + string.count - range.length
                    if (newLength > 40) {
                        return false
                    } else {
                        return true
                    }
                }
            }
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        } else  if textField == txtPassword {
            txtPassword.resignFirstResponder()
            
        }
        return true
    }
}

extension UIViewController {
    func setTitle(_ title: String, andImage image: UIImage) {
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.textColor = UIColor.white
        titleLbl.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        let imageView = UIImageView(image: image)
               imageView.frame = CGRect(x:-20, y: 0, width: 36, height: 36)
            imageView.contentMode = .scaleAspectFit
        let titleView = UIStackView(arrangedSubviews: [imageView, titleLbl])
        titleView.axis = .horizontal
        titleView.spacing = 10.0
        navigationItem.titleView = titleView
        
    }
}
