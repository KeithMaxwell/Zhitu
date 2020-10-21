//
//  ItemList.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/7.
//  Copyright © 2020 maxwell. All rights reserved.
//

import UIKit
enum PropertyType{
    case level
    case tag
}

//enum listType{
//    case system
//    case user
//}

class ItemList{
    static private var itemList:ItemList!
//    static private var userItemList:ItemList!
    
    var list:[Item]

    
    var userContentList:[Item]{
        didSet{
            NotificationCenter.default.post(name: .MKAnnotationCalloutInfoDidChange, object: nil)
        }
    }
    
//    var imageResourceArr:[[String]]
    
    let listDataArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("list.plist")
    }()
    let userContentListDataArchiveURL: URL = {
           let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           let documentDirectory = documentsDirectories.first!
           return documentDirectory.appendingPathComponent("userlist.plist")
       }()
    
    
    @discardableResult @objc func saveChanges() -> Bool{
        print("Saving items to:\(listDataArchiveURL) and \(userContentListDataArchiveURL)")
        do{
            let encoder = PropertyListEncoder()
            let listData = try encoder.encode(list)
            let userContentListData = try encoder.encode(userContentList)
            try listData.write(to: listDataArchiveURL,options: [.atomic])
            try userContentListData.write(to: userContentListDataArchiveURL,options: [.atomic])
            
            print("Saved success")
            
            
            return true
        }catch{
            print("Save failed: \(error)")
            return false
        }
        
    }
    public static func sharedValue() -> ItemList{
        if itemList == nil{
            itemList = ItemList()
            
        }
        return itemList
    }
    
//    public static func userContentValue() -> ItemList{
//
//    }
    
    private init() {
        
        
//        saveChanges()
        
        do{
            let listData = try Data(contentsOf: listDataArchiveURL)
            let userContentListData = try Data(contentsOf: userContentListDataArchiveURL)
            let unarchiver = PropertyListDecoder()
            list = try unarchiver.decode([Item].self, from: listData)
            userContentList = try unarchiver.decode([Item].self, from: userContentListData)
        }catch{
            print(error)
            let description = "北京故宫，即紫禁城，是明清两朝二十四位皇帝的皇宫。故宫始建于明成祖永乐四年（1406年），永乐十八年（1420年）落成；位于北京中轴线的中心，占地面积72万平方米，建筑面积约15万平方米，为世界上现存规模最大的宫殿型建筑。北京故宫是第一批全国重点文物保护单位、的宫殿型建筑。北京故宫是第一批全国重点文物保护单位、第一批国家5A级旅游景区，1987年入选《世界文化遗产》名录。故宫现为故宫博物院，藏品主要以明、清两代宫廷收藏为基础；是国家一级博物馆，与俄罗斯埃米塔什博物馆、法国卢浮宫、美国大都会博物馆、英国大英博物馆并称为世界五大博物馆。"
            
            let item = Item(address:"北京市东城区景山前街4号",title: "故宫", images: ["page3_gugong","page4_gugong"], description: description, officialLevel: .AAAAA, userLevel: .AAAAA, tags: [.mustGo,.nice,.tooMuchPeople,.Majestic,.mustGo,.mustGo,.mustGo,.tooMuchPeople,.tooMuchPeople,.Majestic])
            
            
            
            let item2 = Item(withAnotherItem: item)
            item2.tags = [.tooMuchPeople,.mustGo,.mustGo,.mustGo,.nice,.tooMuchPeople,.Culture,.Majestic,.nice]
            item2.description = "黄鹤楼位于湖北省武汉市长江南岸的武昌蛇山之巅，濒临万里长江，是国家5A级旅游景区，“江南三大名楼”之一，自古享有“天下江山第一楼“和“天下绝景”之称。黄鹤楼是武汉市标志性建筑，与晴川阁、古琴台并称“武汉三大名胜”。黄鹤楼始建于三国时代吴黄武二年（公元223年），三国时期该楼只是夏口城一角瞭望守戍的“军事楼”，晋灭东吴以后，三国归于一统，该楼在失去其军事价值的同时，随着江夏城地发展，逐步演变成为官商行旅“游必于是”、“宴必于是”的观赏楼。唐代诗人崔颢在此题下《黄鹤楼》一诗，李白在此写下《黄鹤楼送孟浩然之广陵》，历代文人墨客在此留下了许多千古绝唱，使得黄鹤楼自古以来闻名遐迩。"
            item2.address = "武汉市武昌区蛇山西山坡特1号"
            item2.officialLevel = .AAAAA
            item2.userLevel = .AAAA
            item2.title = "黄鹤楼"
            item2.images = ["huanghe","huanghe1"]
            
            let item3 = Item(withAnotherItem: item2)
            item3.title = "乐山大佛"
            item3.description = "乐山大佛，又名凌云大佛，位于四川省乐山市南岷江东岸凌云寺侧，濒大渡河、青衣江和岷江三江汇流处。大佛为弥勒佛坐像，通高71米，是中国最大的一尊摩崖石刻造像。乐山大佛开凿于唐代开元元年（713年），完成于贞元十九年（803年），历时约九十年。乐山大佛和凌云山、乌尤山、巨形卧佛等景点组成的乐山大佛景区属于国家5A级旅游景区, 是世界文化与自然双重遗产峨眉山-乐山大佛的组成部分。2018年10月8日，乐山大佛景区九曲栈道处已经开始施工前打围封闭。  2019年4月1日，历时近半年的四川乐山大佛残损区域抢救性保护前期研究及勘测工作结束，乐山大佛正式“出关”，景区的九曲栈道和佛脚观光平台重新开放。  2020年2月，景区宣布对医务人员免门票：向全国医务工作者免费开放一年（含“夜游凌云山”、“夜游三江”体验）。"
            item3.address = "乐山市市中区凌云路中段2435号"
            item3.tags = [.mustGo,.Majestic,.tooMuchPeople,.Majestic,.Majestic,.mustGo,.Culture]
            item3.images = ["leshandafo1","leshandafo2"]
            
            let item4 = Item(withAnotherItem: item2)
            item4.title = "西湖"
            item4.address = "杭州市西湖区龙井路1号"
            item4.description = "西湖，位于浙江省杭州市西湖区龙井路1号，杭州市区西部，景区总面积49平方千米，汇水面积为21.22平方千米，湖面面积为6.38平方千米。西湖南、西、北三面环山，湖中白堤、苏堤、杨公堤、赵公堤将湖面分割成若干水面。西湖的湖体轮廓呈近椭圆形，湖底部较为平坦，湖泊平均水深为2.27米，最深约5米，最浅不到1米。湖泊天然地表水源是金沙涧、龙泓涧、赤山涧（慧因涧）、长桥溪四条溪流。西湖地处中国东南丘陵边缘和中亚热带北缘，年均太阳总辐射量在100—110千卡/平方厘米之间，日照时数1800—2100小时。 西湖有100多处公园景点，有“西湖十景”、“新西湖十景”、“三评西湖十景”之说，  "
            item4.tags = [.tooMuchPeople,.Culture,.nice,.mustGo,.nice,.nice,.nice,.nice,.tooMuchPeople,.mustGo]
            item4.images = ["xihu1","xihu2","xihu3"]
            
            
            let item5 = Item(withAnotherItem: item)
            item5.title = "兵马俑"
            item5.address = "西安市临潼区秦陵北路"
            self.list = [item,item2,item3,item4]
            
            self.userContentList = [item5]
        }
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
//        self.imageResourceArr = [item.images,item2.images,item3.images,item4.images]
    }
    
    public func getCollectionViewDatasources() -> [ImageCollectionViewDatasource]{
        
        var dataSources:[ImageCollectionViewDatasource] = []
        for item in list{
            dataSources.append(ImageCollectionViewDatasource(dataSource: item.images))
        }
//        for item in imageResourceArr{
//            dataSources.append(ImageCollectionViewDatasource(dataSource: item))
//        }
        
        return dataSources
    }
//
//    public static func addItem(to type:listType, item:Item){
//        switch type {
//        case .system:
//            sharedValue().list.append(item)
//        case .user:
//            sharedValue().userContentList.append(item)
//        }
//
//    }
//
//    public static func popItem(from type:listType) -> Item{
//        switch type {
//        case .system:
//            return sharedValue().list.removeLast()
//        case .user:
//            return sharedValue().list.removeLast()
//        }
//
//    }
    
    public static func moreData(){
        for _ in 0..<10{
            let description = "北京故宫，即紫禁城，是明清两朝二十四位皇帝的皇宫。故宫始建于明成祖永乐四年（1406年），永乐十八年（1420年）落成；位于北京中轴线的中心，占地面积72万平方米，建筑面积约15万平方米，为世界上现存规模最大的宫殿型建筑。北京故宫是第一批全国重点文物保护单位、的宫殿型建筑。北京故宫是第一批全国重点文物保护单位、第一批国家5A级旅游景区，1987年入选《世界文化遗产》名录。故宫现为故宫博物院，藏品主要以明、清两代宫廷收藏为基础；是国家一级博物馆，与俄罗斯埃米塔什博物馆、法国卢浮宫、美国大都会博物馆、英国大英博物馆并称为世界五大博物馆。"
            
            let item = Item(address:"北京市东城区景山前街4号",title: "故宫", images: ["page3_gugong","page4_gugong"], description: description, officialLevel: .AAAAA, userLevel: .AAAAA, tags: [.mustGo,.nice,.tooMuchPeople,.Majestic,.mustGo,.mustGo,.mustGo,.tooMuchPeople,.tooMuchPeople,.Majestic])
            
            sharedValue().list.append(item)
            sharedValue().saveChanges()
        }
    }
    
    public static func removeDataFromSystemToUser(item:Item){
        if let index = sharedValue().list.firstIndex(of: item){
            let item = sharedValue().list.remove(at: index)
            item.tags = []
            item.userLevel = .none
            sharedValue().userContentList.append(item)
            
            sharedValue().saveChanges()
        }
        
        
    }
    
    public static func modifify(item:Item,ofProperty type:PropertyType,newValue:Any){
        if let index = sharedValue().userContentList.firstIndex(of: item){
//            print()
//            print("modified value in \(#function): \(sharedValue().list[index].userLevel.rawValue)")
            
            switch type {
            case .level:
                if newValue is Level{
                    sharedValue().userContentList[index].userLevel = (newValue as! Level)
                    print("modified value in \(#function) at line \(#line): \(sharedValue().userContentList[index].userLevel.rawValue)")
                }else{
                    print("newValue is not Level in ItemList at line \(#line)")
                }
                
            case .tag:
                
                if newValue is Tag{
                    sharedValue().userContentList[index].tags.append(newValue as! Tag)
                    print("modified value in \(#function): \(sharedValue().userContentList[index].tags)")
                }else{
                    sharedValue().userContentList[index].tags = []
                }
                
            }
            

            
            sharedValue().saveChanges()
        }
        
    }
    
    
    
}
