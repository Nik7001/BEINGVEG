//
//  SettingVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 24/05/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

    
    @IBOutlet weak var swiftch: UISwitch!
    
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        let image = UIImage(named: "logo")
        setTitle("", andImage: image!)
        
    }
    
    @IBAction func btnProfile(_ sender: Any) {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        let leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        leftViewController.homevc = nvc
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
        UIApplication.shared.delegate?.window??.rootViewController = slideMenuController
    }
    
    @IBAction func btnChangePassword(_ sender: Any) {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "changePasswordVC") as! changePasswordVC
        let leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        leftViewController.homevc = nvc
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
        UIApplication.shared.delegate?.window??.rootViewController = slideMenuController
    }
    
    @IBAction func btnPrivacyPolicy(_ sender: Any) {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "privacyPolicyVC") as! privacyPolicyVC
        let leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        leftViewController.homevc = nvc
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
        UIApplication.shared.delegate?.window??.rootViewController = slideMenuController
    }
    
    @IBAction func btnTerm(_ sender: Any) {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "Term_ConditionVC") as! Term_ConditionVC
        let leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        leftViewController.homevc = nvc
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
        UIApplication.shared.delegate?.window??.rootViewController = slideMenuController
    }
    
    @IBAction func btnNotification(_ sender: Any) {
        
    }
    
    @IBAction func switchOn(_ sender: Any) {
    }
}
