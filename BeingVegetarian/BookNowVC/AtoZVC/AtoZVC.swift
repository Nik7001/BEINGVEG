//
//  AtoZVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 01/06/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class AtoZVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var clctionView: UICollectionView!
    
    var searchcontroller = UISearchController(searchResultsController: nil)
    var SearchData = NSArray()
    var StoreArr = NSArray()
    var arrRestaurentList  = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            setupNavBar()
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view, typically from a nib.
        clctionView.register(UINib.init(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        if let flowLayout = clctionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: view.frame.width,height: 140)
        }
        clctionView.dataSource = self
        clctionView.delegate = self
        WS_topRestaurentVC()
        
    }
    @available(iOS 11.0, *)
    func setupNavBar(){
        
        navigationItem.searchController = searchcontroller
        navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        searchcontroller.obscuresBackgroundDuringPresentation = false
        searchcontroller.searchBar.placeholder = "Search Country"
        definesPresentationContext = true
        searchcontroller.searchResultsUpdater = self
    }
    func filterContentForSearchText(searchText: String) {
        if searchText != "" {
            
            let namePredicate =
                NSPredicate(format: "country_name contains[c] %@",searchText);
            
            SearchData = StoreArr.filter { namePredicate.evaluate(with: $0) } as NSArray
            
            print("storeData",StoreArr)
            
            print("_arrFiltered",SearchData)
            
        }
        else {
            
        }
        self.clctionView.reloadData()
        
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func WS_topRestaurentVC() {
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            
            let  strUrl = WebServicesLink.restaurantname_alphabetically
            
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
                            
                            self.arrRestaurentList = json.GetNSMutableArray(forKey: "RESPONSE")
                            
                            
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrRestaurentList.count;
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        let dict:NSMutableDictionary = self.arrRestaurentList.getNSMutableDictionary(atIndex: indexPath.row)
        let pImage =  dict.GetString(forKey: "image")
        
        cell.img.sd_setImage(with: URL(string:pImage), placeholderImage: UIImage(named: "restaurent"))
        cell.headerLabel.text =  dict.GetString(forKey: "name")
        cell.lblRating.text = dict.GetString(forKey: "rating")
        cell.lblAddress.text = dict.GetString(forKey: "area")
        cell.descriptionLabel.text = dict.GetString(forKey: "description")
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailsVC") as! RestaurantDetailsVC
        let leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        leftViewController.homevc = nvc
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
        UIApplication.shared.delegate?.window??.rootViewController = slideMenuController
    }
    
}
extension AtoZVC: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    private func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: String) {
        filterContentForSearchText(searchText: searchBar.text!)
    }
}

extension AtoZVC: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchText: searchBar.text!)
    }
}
