//
//  MybookingVC.swift
//  Being Vegetarian
//
//  Created by Narendra Thakur on 23/04/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class MybookingVC: UIViewController {

    @IBOutlet weak var clctionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        clctionView.delegate = self
        clctionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        let image = UIImage(named: "logo")
        setTitle("     ", andImage: image!)
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
extension MybookingVC:UICollectionViewDelegate, UICollectionViewDataSource {
    
     func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell:mybookingCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mybookingCollectionCell", for: indexPath) as? mybookingCollectionCell else {
            return UICollectionViewCell()
        }

       cell.img.setShadowOnViewWithRadious(.black, shadowRadius:1.0)
        
        return cell
             
        
      
    }
   
}


class mybookingCollectionCell:  UICollectionViewCell {
    
    @IBOutlet weak var lblDescripttion: UILabel!
    
    @IBOutlet weak var lblNumberofGuest: UILabel!
    
    
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var img: UIImageView!
    
    
}
