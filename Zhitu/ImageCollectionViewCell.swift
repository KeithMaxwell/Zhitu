//
//  ImageCollectionViewCell.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/8.
//  Copyright © 2020 maxwell. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myImage: UIImageView!
    var data:String!{
        didSet{
            myImage.image = UIImage(named: data)
        }
    }
    
    
    
    
}
