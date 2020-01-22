//
//  LaunchViewController.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 26/05/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
 var timer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
     
            self.navigationController?.navigationBar.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let VC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(VC, animated: true)        }
        // Do any additional setup after loading the view.
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

