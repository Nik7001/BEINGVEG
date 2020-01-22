//
//  GallaryVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 31/05/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class GallaryVC: UIViewController {

    @IBOutlet weak var cvGallary: UICollectionView!
    var arrgallaryList = NSMutableArray()
    override func viewDidLoad() {
       cvGallary.delegate = self
        cvGallary.dataSource = self
        super.viewDidLoad()
        self.setNavigationBarItem()
        WS_GallaryList()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        let image = UIImage(named: "logo")
        setTitle("", andImage: image!)
        
    }
    
    func WS_GallaryList() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            
            // var param = [String:Any]()
            //param = [WebServiceConstant.id:userID];
            let  strUrl = WebServicesLink.gallerylist
            
            // print("param >>>>>>>>>>\(param)")
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
                            
                            self.arrgallaryList = json.GetNSMutableArray(forKey: "RESPONSE")
                            self.cvGallary.reloadData()
                            
                            
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
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension GallaryVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
            return arrgallaryList.count;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
            guard let cell:gallaryCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gallaryCVCell", for: indexPath) as? gallaryCVCell
                else {
                return UICollectionViewCell()
           }
        
        let dict:NSMutableDictionary = self.arrgallaryList.getNSMutableDictionary(atIndex: indexPath.row)
        
        let urlstring = dict.GetString(forKey: "image")
        cell.img.sd_setImage(with: URL(string:urlstring), placeholderImage: UIImage(named: "1"))
        cell.setCornerRadiousAndBorder(.lightGray, borderWidth:0.5, cornerRadius: 10)
        return cell
       
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dict:NSMutableDictionary = self.arrgallaryList.getNSMutableDictionary(atIndex: indexPath.row)
        
        
       
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "GallaryDetailVC") as! GallaryDetailVC
        VC.imgUrlString = dict.GetString(forKey: "image")
       VC.Name = dict.GetString(forKey: "title")
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
    
}

class gallaryCVCell:  UICollectionViewCell {
    
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblEventName: UILabel!
    
    
}
