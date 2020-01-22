//
//  RewardsVC.swift
//  Being Vegetarian
//
//  Created by Narendra Thakur on 23/04/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class RewardsVC: UIViewController {
    @IBOutlet weak var viewRewards: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      viewRewards.isHidden = true
      viewRewards.setShadowOnViewWithRadious(.black, shadowRadius:2.0)
        // Do any additional setup after loading the view.
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        let image = UIImage(named: "logo")
        setTitle("", andImage: image!)

    }
    @IBAction func btnOk(_ sender: Any) {
          viewRewards.isHidden = true
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
extension RewardsVC : UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
    let cell = tableView.dequeueReusableCell(withIdentifier: "rewardCell", for: indexPath) as! rewardCell
    cell.viewBack.setShadowOnViewWithRadious(.black, shadowRadius:1.0)
        cell.viewBack.setCornerRadiousAndBorder(.lightGray, borderWidth:0.5)
        return cell
    }
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            viewRewards.isHidden = false
        }

}

class rewardCell: UITableViewCell {
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var lblName: UILabel!
}
    
    
    


