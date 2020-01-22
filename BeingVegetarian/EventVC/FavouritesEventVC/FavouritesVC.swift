//
//  FavouritesVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 30/05/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class FavouritesVC: UIViewController {
    @IBOutlet weak var tblView: UITableView!
     var UserID = Int()
    var arrFavouriteEvent = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
       tblView.delegate = self
        tblView.dataSource = self
        WS_favouriteEvent()
        // Do any additional setup after loading the view.
    }
    

    //MARK:- WSservices >>>>>>>>>>>>
    func WS_favouriteEvent() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            let dict = AppUserDefault.getUserDetails()
            UserID = dict.GetInt(forKey: "id")
            var param = [String:Any]()
            param = [WebServiceConstant.user_id:UserID];
            let  strUrl = WebServicesLink.favouriteEvent
            
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
                            
                            self.arrFavouriteEvent = json.GetNSMutableArray(forKey: "RESPONSE")
                            self.tblView.reloadData()
                       
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
extension FavouritesVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFavouriteEvent.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesVCCell", for: indexPath) as! FavouritesVCCell
        cell.viewBack.setShadowOnViewWithRadious(.black, shadowRadius:1.0)
        cell.viewBack.setCornerRadiousAndBorder(.lightGray, borderWidth:0.5)
        let dict:NSMutableDictionary = self.arrFavouriteEvent.getNSMutableDictionary(atIndex: indexPath.row)
        cell.lblName.text = dict.GetString(forKey: "name")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let dict:NSMutableDictionary = self.arrFavouriteEvent.getNSMutableDictionary(atIndex: indexPath.row)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "eVentDetailVC") as! eVentDetailVC
           VC.restID = dict.GetInt(forKey: "id")
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}

class FavouritesVCCell: UITableViewCell {
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var lblName: UILabel!
}
