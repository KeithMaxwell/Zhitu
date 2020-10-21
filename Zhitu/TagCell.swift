//
//  TagCell.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/7.
//  Copyright © 2020 maxwell. All rights reserved.
//

import UIKit


class TagCell: UITableViewCell {
    
    
    
    
    
    
//    static var cellNo = -1
//    static var cellNum = 0
    
    //    var no:Int!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var userLevelLabel: UILabel!
    
    @IBOutlet weak var userTagLabel: UILabel!
    
    @IBOutlet weak var tagsView: UIView!
    
    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var firstTag: UILabel!
    @IBOutlet weak var secondTag: UILabel!
    @IBOutlet weak var thirdTag: UILabel!
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    var data:Item!{
        didSet{
            
            let tagLabels:[UILabel] = [firstTag,secondTag,thirdTag]
            for label in tagLabels{
                label.alpha = 0 //先将所有的tag的label设置为不可见
            }
            
            self.titleLabel.text = data.title
            self.addressLabel.text = data.address
            self.userLevelLabel.text = data.userLevel.rawValue
            //        self.userLevelLabel.text = data.userLevel.rawValue
            
            
//            self.userTagLabel.text = data.tags.last?.rawValue
            self.selectionStyle = .none
            if data.tags.count == 0{
                self.userTagLabel.alpha = 0
                self.userTagLabel.text = "未评价"
                self.userTagLabel.tintColor = .red
            }else{
                self.userTagLabel.alpha = 0
                for i in 0..<data.tags.count{
                    if i >= tagLabels.count{
                        break
                    }
                    tagLabels[i].text = data.tags[i].rawValue
                    tagLabels[i].alpha = 1 //设置对应的label的text
                }
            }
            
            
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //        if no != nil{
        //            print("TagView no is not nil at \(#function) in line \(#line)")
        //        }else{
        //            print("TagView no is nil at \(#function) in line \(#line)")
        //        }
        
//        TagCell.cellNo += 1
//
//        let dataList = ItemList.sharedValue().list
//
//        print("TagCell.cellNo=\(TagCell.cellNo)")
//        print("TagCell.cellNum=\(TagCell.cellNum)")
//        if data == nil{
//            if TagCell.cellNo < 0 || TagCell.cellNo >= dataList.count{
//                data = dataList[0]
//            }else{
//                data = dataList[TagCell.cellNo]
//            }
//
//
//            //            print("data is nil.In \(#function) at line \(#line)")
//        }
//
//        print("dataList.count: \(dataList.count)")
        
        //        self.titleLabel.text = data.title
        //        self.addressLabel.text = data.address
        //        self.userLevelLabel.text = data.userLevel.rawValue
        ////        self.userLevelLabel.text = data.userLevel.rawValue
        //        self.userTagLabel.text = data.tags.last?.rawValue
        //        self.selectionStyle = .none
        //
        //        if self.userTagLabel.text == nil{
        //            self.userTagLabel.text = "未评价"
        //            self.userTagLabel.tintColor = .red
        //        }
        
        HelperFunc.makeBorders(view: borderView)
        HelperFunc.makeShadows(view: borderView)
        //        self.borderView.layer.shadowOffset = CGSize(width: 1, height: 1)
        
    }
    
    
    
}
