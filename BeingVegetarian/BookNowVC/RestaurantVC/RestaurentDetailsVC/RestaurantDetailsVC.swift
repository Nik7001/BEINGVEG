//
//  RestaurantDetailsVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 01/06/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class RestaurantDetailsVC: UIViewController {
  @IBOutlet var floatRatingView: FloatRatingView!
    
  
    @IBOutlet weak var tblVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        floatRatingView.backgroundColor = UIColor.clear
        
        /** Note: With the exception of contentMode, type and delegate,
         all properties can be set directly in Interface Builder **/
        floatRatingView.delegate = self
        floatRatingView.contentMode = UIView.ContentMode.scaleAspectFit
        floatRatingView.type = .floatRatings
        
        tblVIew.delegate = self
        tblVIew.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Events"
        let image = UIImage(named: "logo")
        setTitle(" ", andImage: image!)
    }
    
    @IBAction func btnReview(_ sender: Any) {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "RatingVC") as! RatingVC
        let leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        leftViewController.homevc = nvc
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
        UIApplication.shared.delegate?.window??.rootViewController = slideMenuController
    }
    
}
extension RestaurantDetailsVC: FloatRatingViewDelegate {
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        
      self.floatRatingView.rating = rating
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
         self.floatRatingView.rating = rating
    }
    
}
extension RestaurantDetailsVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantDetailCell", for: indexPath) as! RestaurantDetailCell
        //cell.viewBack.setShadowOnViewWithRadious(.black, shadowRadius:1.0)
        //cell.viewBack.setCornerRadiousAndBorder(.lightGray, borderWidth:0.5)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}

class RestaurantDetailCell: UITableViewCell {
    
}

