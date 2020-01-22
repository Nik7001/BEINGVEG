//
//  FAQVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 31/05/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit


class FAQVC: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    var expandData = [NSMutableDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.expandData.append(["isOpen":"1","Name":["How to search for Restaurants?","How to book for more events?","What is the refund policy?","How to cancel a booked event?"],"data":["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"]])
        self.expandData.append(["isOpen":"1","Name":["How to search for Restaurants?","How to book for more events?","What is the refund policy?","How to cancel a booked event?"],"data":["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"]])
        self.expandData.append(["isOpen":"1","Name":["How to search for Restaurants?","How to book for more events?","What is the refund policy?","How to cancel a booked event?"],"data":["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"]])
      tblView.delegate = self
    tblView.dataSource = self
        let headerNib = UINib.init(nibName: "TrackHeaderXib", bundle: Bundle.main)
        tblView.register(headerNib, forHeaderFooterViewReuseIdentifier: "TrackHeaderXib")
   
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

class faqCell:UITableViewCell{
   
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var viewBack: UIView!
}

extension FAQVC : UITableViewDelegate,UITableViewDataSource,trackDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.expandData[section].value(forKey: "isOpen") as! String == "1"{
            return 0
        }else{
            let dataarray = self.expandData[section].value(forKey: "data") as! NSArray
            return dataarray.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.expandData.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell", for: indexPath) as! faqCell
    cell.viewBack.setCornerRadiousAndBorder(.lightGray, borderWidth: 0.1, cornerRadius: 10)
        let dataarray = self.expandData[indexPath.section].value(forKey: "data") as! NSArray
        cell.lblName.text = dataarray[indexPath.row] as? String
    
        return cell
    }
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = tblView.dequeueReusableHeaderFooterView(withIdentifier: "TrackHeaderXib") as! faqHeader
        headerView.backView.setCornerRadiousAndBorder(.lightGray, borderWidth:0.2, cornerRadius: 10)
    
        headerView.delegate = self
        headerView.index = section
         let dataarray = self.expandData[section].value(forKey: "Name") as! NSArray
        if(self.expandData[section].value(forKey: "isOpen") as! String == "1"){
            headerView.imgArrow.transform =  CGAffineTransform.identity
        }else{
             headerView.imgArrow.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        headerView.lblTitle.text = dataarray[section] as? String
      
      
        return headerView
    }
    func trackSelect(index:Int) {
        if(self.expandData[index].value(forKey: "isOpen") as! String == "1"){
            self.expandData[index].setValue("0", forKey: "isOpen")
        }else{
            self.expandData[index].setValue("1", forKey: "isOpen")
        }
        self.tblView.reloadSections(IndexSet(integer: (index)), with: .automatic)
       
    }
    @objc func sectionTapped(_ sender: UITapGestureRecognizer){
    }
}
class TriangleView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
        context.closePath()
        
        context.setFillColor(red: 0.1019607843, green: 0.5490196078, blue: 0.831372549, alpha: 0.60)
        context.fillPath()
    }
}
