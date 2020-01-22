//
//  GallaryDetailVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 17/08/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class GallaryDetailVC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    var imgUrlString = String()
    var Name  = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    lblName.text = Name
        
    img.sd_setImage(with: URL(string:imgUrlString), placeholderImage: UIImage(named: "1"))

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        let image = UIImage(named: "logo")
        setTitle("", andImage: image!)
        
    }
    @IBAction func btnDownLoad(_ sender: Any) {
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
