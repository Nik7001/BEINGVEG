//
//  FeedbackVC.swift
//  Being Vegetarian
//
//  Created by Narendra Thakur on 23/04/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit
    class FeedbackVC: UIViewController {
        @IBOutlet weak var segmentedControl: UISegmentedControl!
      @IBOutlet weak var scrollView: UIScrollView!
        override func viewDidLoad() {
            super.viewDidLoad()
           
            
            // segmentedControl.indicator.lineView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
         
            
            // Do any additional setup after loading the view.
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.setNavigationBarItem()
            self.title = "Events"
            let image = UIImage(named: "logo")
            setTitle(" ", andImage: image!)
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
