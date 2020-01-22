//
//  BaseTableViewCell.swift
//  SlideMenuControllerSwift

//
import UIKit

open class BaseTableViewCell : UITableViewCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
    }
    
    open override func awakeFromNib() {
    }
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.alpha = 0.4
        } else {
            self.alpha = 1.0
        }
    }
    
    // ignore the default handling
    override open func setSelected(_ selected: Bool, animated: Bool) {
    }
  
}
