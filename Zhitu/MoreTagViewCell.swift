//
//  MoreTagViewCell.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/8.
//  Copyright © 2020 maxwell. All rights reserved.
//

import UIKit

class MoreTagViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bubleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var contentLabelOutline: UIView!
    
    var data:MoreTagItem!{
        didSet{
            self.bubleLabel.text = "\(data.bubleCount)"
            self.contentLabel.text = "\(data.title)"
            
            if data.bubleCount < 2{
                self.bubleLabel.alpha = 0
            }
            initLayer()
            
        }
    }
    
//    override class func awakeFromNib() {
//
//    }
    
    func initLayer(){
        
        
        contentLabelOutline.layer.borderWidth = 1
        contentLabelOutline.layer.borderColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 1).cgColor
        contentLabelOutline.layer.cornerRadius = 10
        
        
        
        bubleLabel.layer.borderWidth = 1
        bubleLabel.layer.borderColor = UIColor.lightGray.cgColor
        bubleLabel.layer.cornerRadius = 10
        bubleLabel.layer.backgroundColor = UIColor.white.cgColor
        
        
        
        
        
    }
    
    
//    override class func awakeFromNib() {
//        super.awakeFromNib()
//
//
//    }
}
