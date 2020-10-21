//
//  Tag.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/8.
//  Copyright © 2020 maxwell. All rights reserved.
//

import Foundation
enum Tag:String,Codable{
    case nice = "👍风景优美"
    case mustGo = "👍必去"
    case tooMuchPeople = "😩游客太多"
    case Majestic = "👍巍峨险峻"
    case Culture = "👍文化底蕴"
    
    
    static func getAllTags() -> [Tag]{
        
        return [.nice,.mustGo,.Majestic,.tooMuchPeople,.Culture]
    }
    static func getAllTagsOfStr() -> [String]{
        return [Tag.nice.rawValue,Tag.mustGo.rawValue,Tag.Majestic.rawValue,Tag.tooMuchPeople.rawValue,Tag.Culture.rawValue]
    }
}
