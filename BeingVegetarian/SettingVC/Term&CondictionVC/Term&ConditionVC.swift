//
//  Term&ConditionVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 14/07/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class Term_ConditionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
