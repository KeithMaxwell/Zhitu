//
//  MoreTagViewDataSource.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/8.
//  Copyright © 2020 maxwell. All rights reserved.
//

import UIKit

class MoreTagViewDataSource: NSObject,UICollectionViewDataSource {
    
    var dataSource:[MoreTagItem]
    
    init(dataSource:[MoreTagItem]) {
        self.dataSource = dataSource
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("dataSource.count=\(dataSource.count) in MoreTagViewDataSource at line \(#line)")
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("数据源方法被调用了")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreTagViewCell", for: indexPath) as! MoreTagViewCell
        
        cell.data = dataSource[indexPath.row]
        
        
        return cell
    }
    
    
    
}
