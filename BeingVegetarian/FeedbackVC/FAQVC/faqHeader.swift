//
//  faqHeader.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 16/08/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit
@objc protocol trackDelegate{
    @objc optional func trackSelect(index:Int)
}
class faqHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var imgArrow: UIImageView!
    
    @IBOutlet weak var viewHeadBack: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var backView: UIView!
    
   
    
    
    var index = Int()
    var delegate:trackDelegate?
    
    @IBAction func btnClick(_ sender: Any) {
        delegate?.trackSelect!(index: index)
    }
    

}
