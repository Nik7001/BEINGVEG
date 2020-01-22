//
//  BookNowVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 01/06/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit
class BookNowVC: UIViewController {
    @IBOutlet weak var SegmentControl: UISegmentedControl!
    
    var restaurant_banner = NSMutableArray()
    
    @IBOutlet weak var pageControll: UIPageControl!
    
    @IBOutlet weak var clctionVew: UICollectionView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WS_BanneList()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "BOOK NOW"
        let image = UIImage(named: "logo")
        setTitle("", andImage: image!)
    }
    //MARK:- WSservices >>>>>>>>>>>>
    func WS_BanneList() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
     
            let  strUrl = WebServicesLink.restaurant_banner
            
            //print("param >>>>>>>>>>\(param)")
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
                            
                        self.restaurant_banner = json.GetNSMutableArray(forKey: "RESPONSE")
                       
                    Timer.scheduledTimer(timeInterval:0.6, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
                        self.clctionVew.reloadData()
                            
                            
                            
                            
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
   
    @objc func scrollAutomatically(_ timer1: Timer) {
        
        if let coll  = clctionVew {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)!  < restaurant_banner.count - 1){
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
    
}



extension BookNowVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //Mange paggination
        if scrollView == self.clctionVew {
            pageControll.numberOfPages = restaurant_banner.count
            let pageWidth = scrollView.frame.size.width
            let page:NSInteger = Int(scrollView.contentOffset.x/pageWidth)
            pageControll.currentPage = page
           
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return restaurant_banner.count;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
            guard let cell:bookNowCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookNowCell", for: indexPath) as? bookNowCell else {
                return UICollectionViewCell()
                
            }
        let dict:NSMutableDictionary = self.restaurant_banner.getNSMutableDictionary(atIndex: indexPath.row)
        let pImage =  dict.GetString(forKey: "image")
        
        cell.img.sd_setImage(with: URL(string:pImage), placeholderImage: UIImage(named: "image"))
            return cell
        }
  
}
class bookNowCell:  UICollectionViewCell {
    
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblEventName: UILabel!
    
    
}
