//
//  changePasswordVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 14/07/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class changePasswordVC: UIViewController {
    @IBOutlet weak var txtOldP: UITextField!
    
    @IBOutlet weak var txtNewP: UITextField!
    
    @IBOutlet weak var txtConfirmP: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        let image = UIImage(named: "logo")
        setTitle("   ", andImage: image!)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnChangePassword(_ sender: Any) {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        leftViewController.homevc = nvc
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
        UIApplication.shared.delegate?.window??.rootViewController = slideMenuController
    }
    
}
