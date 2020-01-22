//
//  NearByRestaurentVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 17/08/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class NearByRestaurentVC: UIViewController {
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let image = UIImage(named: "logo")
        setTitle("", andImage: image!)
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    @IBAction func btnSkip(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }

}
extension NearByRestaurentVC : UITableViewDelegate,UITableViewDataSource{
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 155
        }
        
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "nearByCell", for: indexPath) as! nearByCell
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let VC = storyboard.instantiateViewController(withIdentifier: "eVentDetailVC") as! eVentDetailVC
//            self.navigationController?.pushViewController(VC, animated: true)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


class nearByCell: UITableViewCell {
    @IBOutlet weak var restaurentimage: UIImageView!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var test: UILabel!
    
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    
    @IBOutlet weak var lblContaint: UILabel!
}
