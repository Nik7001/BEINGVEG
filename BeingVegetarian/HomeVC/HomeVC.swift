//
//  HomeVC.swift
//  Being Vegetarian
//
//  Created by Narendra Thakur on 23/04/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    var userID = String()
    var timer: Timer?

    @IBOutlet weak var btnHide: UIButton!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var viewOwner: UIView!
    
    @IBOutlet weak var pageControll: UIPageControl!
    
    @IBOutlet weak var clctionVew: UICollectionView!
    
    @IBOutlet weak var clctionViewIntro: UICollectionView!
    
    @IBOutlet weak var btnRestaurantRegistration: UIButton!
    
    var Events = ["EVENTS", "BOOK NOW","VEGETARIANISM","GALLARY"]
    
    var EventsImg = ["calendar","recipe_book","diet","picture"]
    
 var bannerAdd = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          pageControll.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
       
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstTime") == nil {
            defaults.set("No", forKey:"isFirstTime")
            defaults.synchronize()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NearByRestaurentVC") as! NearByRestaurentVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
        
        WS_BanneList()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        
        let image = UIImage(named: "logo")
        setTitle("", andImage: image!)
        viewOwner.isHidden = true
        backView.isHidden = true
        btnHide.isHidden = true
        viewOwner.setCornerRadiousAndBorder(.lightGray, borderWidth: 1, cornerRadius: 4)
        
    }
    @objc func scrollAutomatically(_ timer1: Timer) {
        
        if let coll  = clctionViewIntro {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)!  < bannerAdd.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    self.scrollViewDidEndDecelerating(coll)
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    self.scrollViewDidEndDecelerating(coll)
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
                
            }
        }
    }
        
    
    @IBAction func btnViewHide(_ sender: Any) {
        viewOwner.isHidden = true
        backView.isHidden = true
        btnHide.isHidden = true
    }
    
    @IBAction func btnContinue(_ sender: Any) {
        viewOwner.isHidden = true
        backView.isHidden = true
        btnHide.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let VC = storyboard.instantiateViewController(withIdentifier: "RegisterRestaurantVC") as! RegisterRestaurantVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        viewOwner.isHidden = true
        backView.isHidden = true
        btnHide.isHidden = true
    }
    
    @IBAction func btnRestaurant(_ sender: Any) {
        viewOwner.isHidden = false
        backView.isHidden = false
        btnHide.isHidden = false
    }
    
    //MARK:- WSservices >>>>>>>>>>>>
    func WS_BanneList() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
           
           
            
          
            var param = [String:Any]()
            param = [WebServiceConstant.id:userID];
            let  strUrl = WebServicesLink.bannerList
            
            print("param >>>>>>>>>>\(param)")
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
                            
                             self.bannerAdd = json.GetNSMutableArray(forKey: "RESPONSE")
                            Timer.scheduledTimer(timeInterval:0.6, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
                            
                            self.clctionViewIntro.reloadData()
                            
                            
                            
                           
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
extension HomeVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //Mange paggination
        if scrollView == self.clctionViewIntro {
             pageControll.numberOfPages = bannerAdd.count
            let pageWidth = scrollView.frame.size.width
            let page:NSInteger = Int(scrollView.contentOffset.x/pageWidth)
            pageControll.currentPage = page
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clctionViewIntro{
            return bannerAdd.count;
        }else{
           return Events.count
        }
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == clctionViewIntro{
            guard let cell:introCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "introCollectionCell", for: indexPath) as? introCollectionCell else {
                return UICollectionViewCell()
               
            }
          let dict:NSMutableDictionary = self.bannerAdd.getNSMutableDictionary(atIndex: indexPath.row)
            let pImage =  dict.GetString(forKey: "image")
            
            cell.img.sd_setImage(with: URL(string:pImage), placeholderImage: UIImage(named: "image"))
            
            
            return cell
        }else{
            guard let cell:CollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionCell else {
                return UICollectionViewCell()
            }
            cell.lblEventName.text = Events[indexPath.row]
            cell.img.image = UIImage(named: EventsImg[indexPath.row])
            return cell
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == clctionViewIntro{
            let dict:NSMutableDictionary = self.bannerAdd.getNSMutableDictionary(atIndex: indexPath.row)
          
            guard let url = URL(string:  dict.GetString(forKey: "link")) else { return }
            UIApplication.shared.open(url)
            
        }else{
          let index = Events[indexPath.row]
            if index == "GALLARY"{
                let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "GallaryVC") as! GallaryVC
                let leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
                let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
                leftViewController.homevc = nvc
                let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
                slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
                UIApplication.shared.delegate?.window??.rootViewController = slideMenuController
            }
            if index == "EVENTS"{
                let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventsVC") as! EventsVC
                let leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
                let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
                leftViewController.homevc = nvc
                let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
                slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
                UIApplication.shared.delegate?.window??.rootViewController = slideMenuController
            }
            
            if index == "BOOK NOW"{
                let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "BookNowVC") as! BookNowVC
                let leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
                let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
                leftViewController.homevc = nvc
                let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
                slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
                UIApplication.shared.delegate?.window??.rootViewController = slideMenuController
            }
            
            
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == clctionViewIntro{
             return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else{
             return UIEdgeInsets.init(top: 0, left: 2, bottom: 0,right: 2)
        }
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == clctionViewIntro{
               return collectionView.bounds.size
        }else{
           return CGSize(width: (self.clctionVew.frame.size.width/2)-10, height:126)
        }
     
        
    }
}






class introCollectionCell:  UICollectionViewCell {
   
    
    @IBOutlet weak var img: UIImageView!
    
    
}
class CollectionCell:  UICollectionViewCell {
    
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblEventName: UILabel!
    
    
}
