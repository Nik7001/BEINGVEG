//
//  CountryVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 06/06/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

protocol CountryDelegate {
    func valueLable(countryData : NSDictionary)
}


class CountryVC: UIViewController {
 var delegate : CountryDelegate?
    
    @IBOutlet weak var tblview: UITableView!
    
    var arrCountry = NSMutableArray()
    var SearchData = NSArray()
    var StoreArr = NSArray()
    var veryfySignup = String()
   var searchcontroller = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       tblview.delegate = self
        tblview.dataSource = self
        
                if #available(iOS 11.0, *) {
            setupNavBar()
          self.navigationController?.navigationBar.isHidden = false
           self.title = "Select Country"
            //let image = UIImage(named: "")
            //setTitle("", andImage: image!)
        } else {
        //setupNavBar()
        }
        ws_getCountry()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.navigationBar.isHidden = false
        
        
        
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
         self.tblview.reloadData()
      
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func ws_getCountry(){
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            WebService.createRequestAndGetResponse(WebServicesLink.getCountry, methodType: .GET, andHeaderDict: [:], andParameterDict: [:], onCompletion: { (dictResponse, error, reply, statusCode) in
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
                            self.tblview.displayBackgroundText(text: "", textColor: .clear)
                            self.arrCountry = json.GetNSMutableArray(forKey: "RESPONSE")

                            self.StoreArr = json.GetNSArray(forKey: "RESPONSE")
                            print("StoreArr",self.StoreArr)
                            self.tblview.reloadData()
                            
                        } else if json.GetInt(forKey:"RESPONSECODE") == 0 {
                        self.tblview.displayBackgroundText(text: msg, textColor: UIColor.black)
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
extension CountryVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return SearchData.count
        }
            return arrCountry.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! countryCell
        if isFiltering() {
        
           // let descriptor: NSSortDescriptor = NSSortDescriptor(key: "country_name", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
           // let sortedResults: NSArray = SearchData.sortedArray(using: [descriptor]) as NSArray
            let newArr:NSDictionary = SearchData[indexPath.row] as! NSDictionary
            print("newArr",newArr)
            
            cell.lblName.text =  newArr.GetString(forKey: "country_name")
           
        }else{
            
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "country_name", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
            let sortedResults: NSArray = arrCountry.sortedArray(using: [descriptor]) as NSArray
            let newArr:NSDictionary = sortedResults[indexPath.row] as! NSDictionary
            print("newArr",newArr)
            cell.lblName.text =  newArr.GetString(forKey: "country_name")
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if veryfySignup == "1"{
        if isFiltering() {
            let newArr:NSDictionary = SearchData[indexPath.row] as! NSDictionary
        
            delegate?.valueLable(countryData:newArr )
             self.navigationController?.popViewController(animated: true)

            
        }else{
            let newArr:NSDictionary = arrCountry[indexPath.row] as! NSDictionary
            delegate?.valueLable(countryData:newArr )
        self.navigationController?.popViewController(animated: true)

        }
    }
        else{
            if isFiltering() {
                let newArr:NSDictionary = SearchData[indexPath.row] as! NSDictionary
              
                delegate?.valueLable(countryData:newArr )
                self.navigationController?.popViewController(animated: true)

                
            }else{
                let newArr:NSDictionary = arrCountry[indexPath.row] as! NSDictionary
               
                delegate?.valueLable(countryData:newArr )
                self.navigationController?.popViewController(animated: true)
            }
        }
   }
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchcontroller.searchBar.selectedScopeButtonIndex != 0
        return searchcontroller.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchcontroller.searchBar.text?.isEmpty ?? true
    }
    
}
class countryCell:  UITableViewCell {
   
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblPhoneCode: UILabel!
}
extension CountryVC: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    private func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: String) {
        filterContentForSearchText(searchText: searchBar.text!)
    }
}

extension CountryVC: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchText: searchBar.text!)
    }
}

