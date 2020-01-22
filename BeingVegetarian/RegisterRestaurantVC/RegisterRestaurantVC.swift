//
//  RegisterRestaurantVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 01/06/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit
import CoreLocation
class RegisterRestaurantVC: UIViewController,CLLocationManagerDelegate,UITextViewDelegate {
    let regularFont = UIFont.systemFont(ofSize: 14)
    let boldFont = UIFont.boldSystemFont(ofSize: 14)
    
    @IBOutlet weak var btnUploadImage: UIButton!
    
    @IBOutlet weak var btnHide: UIButton!
    
    @IBOutlet weak var ViewMoreDetails: UIView!
    
    @IBOutlet weak var txtclose: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var txtRestaurenrName: UITextField!
    
    @IBOutlet weak var txtOpn: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    
    @IBOutlet weak var CausineOffer: UIButton!
    
    @IBOutlet weak var opentime: UIButton!
    
    
    @IBOutlet weak var txtDesription: UITextView!
    
    @IBOutlet weak var btnPremium: UIButton!
    
    @IBOutlet weak var btnNormal: UIButton!
    
    
    @IBOutlet weak var closetime: UIButton!
    
    var imagePicker = UIImagePickerController()
    var choosenImage = UIImage()
    var base64Image = String()
    var locationManager = CLLocationManager()
    var latitude = String()
    var longitude = String()
    var arrCuisines = NSMutableArray()
    var arrNewCuisines = [String]()
    var values = [String]()

    var subscription = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        WS_ChineseList()
    self.locationManager.requestAlwaysAuthorization()
        
        btnHide.isHidden = true
        ViewMoreDetails.isHidden = true
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
   txtRestaurenrName
    .setCornerRadiousAndBorder(.white, borderWidth: 1, cornerRadius: 10)
 txtArea.setCornerRadiousAndBorder(.white, borderWidth: 1, cornerRadius: 10)
 txtDesription.setCornerRadiousAndBorder(.white, borderWidth: 1, cornerRadius: 10)
   CausineOffer.setCornerRadiousAndBorder(.white, borderWidth: 1, cornerRadius: 10)
    txtclose.setCornerRadiousAndBorder(.white, borderWidth: 1, cornerRadius: 10)
    txtOpn.setCornerRadiousAndBorder(.white, borderWidth: 1, cornerRadius: 10)
        CausineOffer.setCornerRadiousAndBorder(.white, borderWidth: 1, cornerRadius: 10)
        subscription = "1"
        imagePicker.delegate = self

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let image = UIImage(named: "logo")
        setTitle(" BEING VEGETARIAN", andImage: image!)
    self.navigationController?.navigationBar.topItem?.title = ""

    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        latitude = ("locations = \(locValue.latitude)")
        longitude = ("locations = \(locValue.longitude)")
    }
    
    @IBAction func btnPrimuimAct(_ sender: Any) { btnNormal.setImage(UIImage(named: "unselect"), for: .normal)
        btnPremium.setImage(UIImage(named: "select"), for: .normal)
        btnRegister.setTitle("MAKE PAYMENT", for:.normal)
      subscription = "2"
    }
    
    
    @IBAction func btnNormalAct(_ sender: Any) {
      
        btnNormal.setImage(UIImage(named: "select"), for: .normal)
        btnPremium.setImage(UIImage(named: "unselect"), for: .normal)
        btnRegister.setTitle("REGISTER RESTAURANT", for:.normal)
        subscription = "1"
    }
    
    @IBAction func btnChinese(_ sender: Any) {
        
       
        let blueAppearance = YBTextPickerAppearanceManager.init(
            pickerTitle         : "Cuisines List",
            titleFont           : boldFont,
            titleTextColor      : .black,
            titleBackground     : .clear,
            searchBarFont       : regularFont,
            searchBarPlaceholder: "Search ",
            closeButtonTitle    : "Cancel",
            closeButtonColor    : .darkGray,
            closeButtonFont     : regularFont,
            doneButtonTitle     : "Done",
            doneButtonColor     : .green,
            doneButtonFont      : boldFont,
            checkMarkPosition   : .Right,
            itemCheckedImage    : UIImage(named:"check"),
            itemUncheckedImage  : UIImage(named: "unselect"),
            itemColor           : .black,
            itemFont            : regularFont
        )
        
        let picker = YBTextPicker.init(with: arrNewCuisines, appearance: blueAppearance,
                                       onCompletion: { (selectedIndexes, selectedValues) in
                                        if selectedValues.count > 0{
                                        
                                            self.values = [String]()
                                            for index in selectedIndexes{
                                                self.values.append(self.arrNewCuisines[index])
                                            }
                                            
                                            
                                            self.CausineOffer.setTitle(self.values.joined(separator: ", "), for: .normal)
                                            
                                        }else{
                                            self.CausineOffer.setImage(UIImage.init(named: "check"), for: .normal)
                                            self.CausineOffer.setTitle(self.arrNewCuisines[0], for: .normal)
                                        }
        },
                                       onCancel: {
                                        print("Cancelled")
        }
        )
        
        if let title = CausineOffer.title(for: .normal){
            if title.contains(","){
                picker.preSelectedValues = title.components(separatedBy: ", ")
            }
        }
        picker.allowMultipleSelection = true
        
        picker.show(withAnimation: .Fade)
    }
    
    
    
    @IBAction func btnUpload(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as? UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnRegisterRestaurant(_ sender: Any) {
        
        if btnRegister.currentTitle == "REGISTER RESTAURANT"{
            self.hideKeyBoard()
            var arrvalid = NSMutableArray()
            arrvalid = CheckValidation()
            if arrvalid.count == 0{
                WS_registerRestorant()
                
            } else {
                PopUpView.addValidationView(arrvalid, strHeader: MessageStringFile.whoopsText(), strSubHeading: MessageStringFile.vInfoNeeded())
                PopUpView.sharedInstance.delegate = nil
            }
        }
        else{
        
        }
       
    }
    
    @IBAction func btnOpentime(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Time Picker", picker: { (picker) in
            picker.date = Date()
            picker.datePickerMode = .time
        }) { (date, cancel) in
            if !cancel {
                // TODO: you code here
                debugPrint(date as Any)
                let formatter = DateFormatter()
                
                formatter.dateFormat = "HH:mm"
                
                let myString = formatter.string(from: date!)
                let yourDate = formatter.date(from: myString)
                
                formatter.dateFormat = "HH:mm"
                // again convert your date to string
                let myStringafd = formatter.string(from: yourDate!)
                
                print(myStringafd)
                
                self.opentime.setTitle(myStringafd, for: .normal)
                debugPrint(date as Any)
            }
        }
        
    }
    
    @IBAction func btnMoreDetails(_ sender: Any) {
        btnHide.isHidden = false
        ViewMoreDetails.isHidden = false
    }
    
    
    @IBAction func btnCloseTime(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Time Picker", picker: { (picker) in
            picker.date = Date()
            picker.datePickerMode = .time
        }) { (date, cancel) in
            if !cancel {
               print("",date)
               
           
                let formatter = DateFormatter()
                
                formatter.dateFormat = "HH:mm"
                
                let myString = formatter.string(from: date!)
                let yourDate = formatter.date(from: myString)
                
                formatter.dateFormat = "HH:mm"
                // again convert your date to string
                let myStringafd = formatter.string(from: yourDate!)
                
                print(myStringafd)
                
                self.closetime.setTitle(myStringafd, for: .normal)
            
            }
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
    
    //MARK:- WSservices >>>>>>>>>>>>
    func WS_registerRestorant() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            
            var param = [String:Any]()
            let dict =  AppUserDefault.getUserDetails()
            print("dict111",dict)
            let userId = dict.GetInt(forKey: "id")
            let  strUrl = WebServicesLink.restorent_register
          
            
            param = [WebServiceConstant.user_id:userId,WebServiceConstant.name:txtRestaurenrName.text!,WebServiceConstant.area:txtArea.text!,WebServiceConstant.latitude:latitude,WebServiceConstant.longitude:longitude,WebServiceConstant.cuisines_offer:CausineOffer.currentTitle ?? "",WebServiceConstant.openning_time:opentime.currentTitle ?? "" ,WebServiceConstant.closing_time:closetime.currentTitle ?? "",WebServiceConstant.description:txtDesription ?? "",WebServiceConstant.image:choosenImage,WebServiceConstant.subscription:subscription]
            
            
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
    
    //MARK:- WSservices >>>>>>>>>>>>
    func WS_ChineseList() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            
            let  strUrl = WebServicesLink.cuisines_list
            
           
            print("param >>>>>>>>>>\(strUrl)")
            
            WebService.createRequestAndGetResponse(strUrl, methodType: .GET, andHeaderDict:[:], andParameterDict: [:], onCompletion: { (dictResponse,error,reply,statusCode) in
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
                            
                            self.arrCuisines = json.GetNSMutableArray(forKey: "RESPONSE")
                            for cusines in self.arrCuisines{
                                let dic = cusines as! NSMutableDictionary
                            self.arrNewCuisines.append(dic.GetString(forKey: "title"))
                            }
       self.CausineOffer.setTitle(self.arrNewCuisines[0], for: .normal)
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
        txtRestaurenrName.delegate = self
        txtArea.delegate = self
        txtDesription.delegate = self
       
    }
    
    //MARK:- Functions >>>>>>>>>>>>>
    func hideKeyBoard(){
        txtArea.resignFirstResponder()
        txtDesription.resignFirstResponder()
        txtRestaurenrName.resignFirstResponder()
      
    }
    //MARK:- Validation >>>>>>>>>>>>>
    func CheckValidation() -> NSMutableArray {
        let arrValidation = NSMutableArray()
        if txtRestaurenrName.text?.count == 0 {
        arrValidation.add(MessageStringFile.restorantName())
        }
        if txtArea.text?.count == 0 {
            arrValidation.add(MessageStringFile.area())
        }
        if txtDesription.text?.count == 0 {
            arrValidation.add(MessageStringFile.description())
        }
       
        
        
        return arrValidation
    }
  
    @IBAction func btnBAckHide(_ sender: Any) {
        btnHide.isHidden = true
        ViewMoreDetails.isHidden = true
    }
    
    @IBAction func brnOK(_ sender: Any) {
        btnHide.isHidden = true
        ViewMoreDetails.isHidden = true
    }
    
    
    
}
extension RegisterRestaurantVC: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension RegisterRestaurantVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            choosenImage = image
            btnUploadImage.setImage(image, for: .normal)
        } else if let image = info["UIImagePickerControllerEditedImage"] as? UIImage {
            choosenImage = image
            btnUploadImage.setImage(image, for: .normal)
            
            
        }
        let imageData:NSData = choosenImage.pngData()! as NSData
        //self.imgProfile.image = choosenImage
       // let imgdata = UIImageJPEGRepresentation(choosenImage, 0.5)
        
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        print(strBase64)
        base64Image = strBase64
        picker.dismiss(animated: true, completion: nil);
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }



// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
 }
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    
}
