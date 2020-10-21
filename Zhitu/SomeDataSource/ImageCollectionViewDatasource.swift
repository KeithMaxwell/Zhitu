//
//  ImageCollectionViewDatasource.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/8.
//  Copyright © 2020 maxwell. All rights reserved.
//

import UIKit

class ImageCollectionViewDatasource: NSObject, UICollectionViewDataSource {
    
    var datasource:[String]
    
    init(dataSource:[String]) {
//        super.init()
        self.datasource = dataSource
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        cell.data = datasource[indexPath.row]
        return cell
        
    }
    

}
