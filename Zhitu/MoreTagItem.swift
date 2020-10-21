//
//  MoreTagItem.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/8.
//  Copyright © 2020 maxwell. All rights reserved.
//

import Foundation

class MoreTagItem:Equatable{
    static func == (lhs: MoreTagItem, rhs: MoreTagItem) -> Bool {
        return lhs.bubleCount == rhs.bubleCount && lhs.title == rhs.title
    }
    
    var title:String = "风景优美"
    var bubleCount:Int = 1
    
    init(title:String,bubleCount:Int) {
        self.title = title
        self.bubleCount = bubleCount
    }
    
   
}

