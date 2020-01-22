//
//  MyRestaurantVC.swift
//  Being Vegetarian
//
//  Created by Narendra Thakur on 23/04/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class MyRestaurantVC: UIViewController {
    

    @IBOutlet weak var clctionView: UICollectionView!
    
    var arrMyRestaurant = NSMutableArray()
    var userID = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        WS_MyRestaurant()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
       let image = UIImage(named: "logo")
        setTitle("   ", andImage: image!)

        //http://being.easyeducation.in/webservice.php?action=myrestaurant&user_id=2

    }
    //MARK:- WSservices >>>>>>>>>>>>
    func WS_MyRestaurant() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            
            let dict =  AppUserDefault.getUserDetails()
            print("dict111",dict)
            userID = dict.GetInt(forKey: "id")
            
            var param = [String:Any]()
            param = [WebServiceConstant.user_id:userID];
            let  strUrl = WebServicesLink.myrestaurant
            
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
                            
                            self.arrMyRestaurant = json.GetNSMutableArray(forKey: "RESPONSE")
                            
                            self.clctionView.reloadData()
                            
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
extension MyRestaurantVC:UICollectionViewDelegate, UICollectionViewDataSource,CellDelegate {
   
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMyRestaurant.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell:myRestaurantCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myRestaurantCollectionCell", for: indexPath) as? myRestaurantCollectionCell else {
            return UICollectionViewCell()
        }
        let dict:NSMutableDictionary = self.arrMyRestaurant.getNSMutableDictionary(atIndex: indexPath.row)
        
        let pImage =  dict.GetString(forKey: "image")
        
        cell.img.sd_setImage(with: URL(string:pImage), placeholderImage: UIImage(named: "back_desk"))
        cell.img.setShadowOnViewWithRadious(.black, shadowRadius:1.0)
        cell.lblName.text = dict.GetString(forKey: "name")
        cell.lblAdd.text = dict.GetString(forKey: "area")
        cell.lbltime.text = dict.GetString(forKey: "openning_time") + "to" + " "  + dict.GetString(forKey: "closing_time")
        cell.lbcuiseOffer.text = dict.GetString(forKey: "cuisines_offer")
        cell.lblDesc.text = "Description:" + dict.GetString(forKey: "description")
        
       cell.delegate = self

        return cell
        
        
        
    }
    
    func didTapButton(_ sender: myRestaurantCollectionCell) {
        guard let tappedIndexPath = clctionView.indexPath(for: sender) else { return }
        print("Trash", sender, tappedIndexPath)
        let dict:NSMutableDictionary = self.arrMyRestaurant[tappedIndexPath.row] as! NSMutableDictionary
        print("dict",dict)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditRestaurentViewController") as! EditRestaurentViewController
        vc.dict = dict
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    
    
    
  
    
}

protocol CellDelegate: class {
    func didTapButton(_ sender: myRestaurantCollectionCell)
}
class myRestaurantCollectionCell:  UICollectionViewCell {
    weak var delegate: CellDelegate?
    
   
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnNormal: UIButton!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblAdd: UILabel!
    
    @IBOutlet weak var lbcuiseOffer: UILabel!
    
    @IBOutlet weak var lbltime: UILabel!
    
    @IBOutlet weak var lblDesc: UILabel!
    
    @IBOutlet weak var btnReadMore: UIButton!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var btnDelete: UIButton!
    
    
    @IBAction func btnEditAct(_ sender: Any) {
         delegate?.didTapButton(self)
    }
    
    
    @IBAction func btnDeleteAct(_ sender: Any) {
    }
    
    @IBAction func btReadeMoreAct(_ sender: Any) {
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
    }
    
}

