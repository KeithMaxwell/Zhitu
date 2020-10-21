//
//  Item.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/6.
//  Copyright © 2020 maxwell. All rights reserved.
//

import UIKit




class Item:Equatable,Codable{
    static func == (lhs: Item, rhs: Item) -> Bool {
        var result = true
        if(lhs.tags.count == rhs.tags.count){
            if lhs.tags.count == 0{
                result = true
            }else{
                for i in 0...(lhs.tags.count-1){
                   result = lhs.tags[i] == rhs.tags[i]
                   if !result{
                       break
                   }
               }
            }
           
        }
        
        return lhs.address == rhs.address && lhs.title == rhs.title && lhs.images == rhs.images && lhs.description == rhs.description && lhs.officialLevel == rhs.officialLevel && lhs.userLevel == rhs.userLevel && result
    }
    
    var address:String = "北京市东城区景山前街4号"
    var title:String = "default"
    var images:[String] = ["page3_gugong"]
    var description:String = "default"
    var officialLevel:Level = .AAAAA
    var userLevel:Level = .AAAAA
    var tags:[Tag] = [.mustGo,.nice,.tooMuchPeople]
    
    init(address:String,title:String,images:[String],description:String,officialLevel:Level,userLevel:Level,tags:[Tag]) {
        self.address = address
        self.title = title
        self.images = images
        self.description = description
        self.officialLevel = officialLevel
        self.userLevel = userLevel
        self.tags = tags
    }
    
    init() {
        
    }
    
    init(withAnotherItem item:Item) {
        self.title = item.title
        self.images = item.images
        self.description = item.description
        self.officialLevel = item.officialLevel
        self.userLevel = item.userLevel
        self.tags = item.tags
    }
    
    
}

