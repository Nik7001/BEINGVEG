//
//  RatingVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 01/06/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class RatingVC: UIViewController {

    @IBOutlet weak var floatRating2: FloatRatingView!
    
    @IBOutlet var floatRatingView: FloatRatingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        floatRatingView.backgroundColor = UIColor.clear
         floatRating2.backgroundColor = UIColor.clear
        
       
        floatRatingView.delegate = self
        floatRating2.delegate = self
        
        floatRatingView.contentMode = UIView.ContentMode.scaleAspectFit
         floatRating2.contentMode = UIView.ContentMode.scaleAspectFit
        floatRatingView.type = .floatRatings
        floatRating2.type = .floatRatings
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Events"
        let image = UIImage(named: "logo")
        setTitle(" ", andImage: image!)
    }
    
    @IBAction func btnAddReview(_ sender: Any) {
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
extension RatingVC: FloatRatingViewDelegate {
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        
        self.floatRatingView.rating = rating
        self.floatRating2.rating = rating
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        self.floatRatingView.rating = rating
        self.floatRating2.rating = rating
    }
    
}
