//
//  MenuVC.swift
//  Being Vegetarian
//
//  Created by Narendra Thakur on 23/04/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    case home = 0
    case settings
    case help
    case Feedback
    case MyBookings
    case MyRestaurant
    case MyRewards
    case Events
    case Logout
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class MenuVC : UIViewController, LeftMenuProtocol,PopUpViewDelegate {
    var Email = String()
    @IBOutlet weak var labelFullname: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var imgProfile: UIImageView!
   
    
    @IBOutlet weak var tblview: UITableView!
    
    
  
    
    var menus = ["Home", "Settings","Help","FAQ & Feedback","My Bookings","My Restaurant", "My Rewards","Events","Logout"]
    
    var menuImg = ["home","settings","help","feedback","my_booking", "my_restaurent","rewards","event","logout"]
    
    var homevc: UIViewController!
    var settingvc: UIViewController!
    var helpvc: UIViewController!
    var feedbackvc: UIViewController!
    var bookingvc: UIViewController!
    var restaurantvc: UIViewController!
    var rewardvc: UIViewController!
    var eventvc: UIViewController!
    var logoutvc: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dict =  AppUserDefault.getUserDetails()
        print("dict111",dict)
        lblEmail.text = dict.GetString(forKey: "email")
        labelFullname.text = dict.GetString(forKey: "first_name") + dict.GetString(forKey: "last_name")
        let urlstring = dict.GetString(forKey: "picture")
        imgProfile.sd_setImage(with: URL(string:urlstring), placeholderImage: UIImage(named: "user_white"))
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.homevc = UINavigationController(rootViewController: homeVC)
        
        let settingvc = storyboard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.settingvc = UINavigationController(rootViewController: settingvc)
        
        let helpvc = storyboard.instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        self.helpvc = UINavigationController(rootViewController: helpvc)
        
        let feedbackvc = storyboard.instantiateViewController(withIdentifier: "FeedbackVC") as! FeedbackVC
        self.feedbackvc = UINavigationController(rootViewController: feedbackvc)
        let bookingVC = storyboard.instantiateViewController(withIdentifier: "MybookingVC") as! MybookingVC
        self.bookingvc = UINavigationController(rootViewController: bookingVC)
        
        let restorantVC = storyboard.instantiateViewController(withIdentifier: "MyRestaurantVC") as! MyRestaurantVC
        self.restaurantvc = UINavigationController(rootViewController: restorantVC)
        
       
        let rewadsVC = storyboard.instantiateViewController(withIdentifier: "RewardsVC") as! RewardsVC
        self.rewardvc = UINavigationController(rootViewController: rewadsVC)
       
        let EventVC = storyboard.instantiateViewController(withIdentifier: "EventsVC") as! EventsVC
        self.eventvc = UINavigationController(rootViewController: EventVC)
        
        let logoutVC =
            storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.logoutvc = UINavigationController(rootViewController: logoutVC)
        
        self.imgProfile.layer.cornerRadius = self.imgProfile.bounds.size.height / 2
        self.imgProfile.clipsToBounds = true
        self.imgProfile.layer.borderWidth = 1
        self.imgProfile.layer.borderColor = UIColor.clear.cgColor
       
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imgProfile.layoutIfNeeded()
        
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .home:
            self.slideMenuController()?.changeMainViewController(self.homevc, close: true)
            
        case .settings:
            self.slideMenuController()?.changeMainViewController(self.settingvc, close: true)
            
        case .help:
            self.slideMenuController()?.changeMainViewController(self.helpvc, close: true)
            
        case .Feedback:
            self.slideMenuController()?.changeMainViewController(self.feedbackvc, close: true)
            
        case .MyBookings:
            self.slideMenuController()?.changeMainViewController(self.bookingvc, close: true)
            
        case .MyRestaurant:
            self.slideMenuController()?.changeMainViewController(self.restaurantvc, close: true)
            
        case .MyRewards:
            self.slideMenuController()?.changeMainViewController(self.rewardvc, close: true)
            
        case .Events:
            self.slideMenuController()?.changeMainViewController(self.eventvc, close: true)
        case .Logout:
            PopUpView.addPopUpAlertView(MessageStringFile.confirmText(), leftBtnTitle: MessageStringFile.noText(), rightBtnTitle: MessageStringFile.yesText(), firstLblTitle: "Are you sure, you want to logout ?", secondLblTitle: "")
            PopUpView.sharedInstance.delegate = self
            
            break;
        }
    }
    
    //MARK:- POPUP
    func clickOnPopUpLeftButton() {
        
    }
    
    func clickOnPopUpRightButton() {
        AppUserDefault.setUserLoginStatus(status: 0)
    self.slideMenuController()?.changeMainViewController(self.logoutvc, close: true)
        
    }
   
}

extension MenuVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .home, .settings,.help,.Feedback, .MyBookings,.MyRestaurant,.MyRewards,.Events,.Logout:
             
                return 40
            }
        }
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
            
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tblview
            == scrollView {
            
        }
    }
}

extension MenuVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuImg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
              case .home, .settings,.help,.Feedback, .MyBookings,.MyRestaurant,.MyRewards,.Events,.Logout:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "BaseTableViewCell", for: indexPath) as! BaseTableViewCell
                cell.lblName?.text = menus[indexPath.row]
                cell.imgIcon.image = UIImage(named: menuImg[indexPath.row])
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
}
