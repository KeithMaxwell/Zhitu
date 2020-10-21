//
//  MoreTagViewController.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/6.
//  Copyright © 2020 maxwell. All rights reserved.
//

import UIKit

class MoreTagViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    

    
    
    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var BadCollectionView: UICollectionView!
    var data:[Tag]!
    
    var badDataSource:[MoreTagItem] = []
    var goodDataSource:[MoreTagItem] = []
    
    
    func getRepeatTimes(of str:String,in arr:[String]) -> Int{
        
        var arr = arr
        var count = 0
        while arr.contains(str){
            count += 1
            let index = arr.firstIndex(of: str)!
            arr.remove(at: index)
        }
        return count
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if data == nil{
            print("The Damn Data is nil!!! What the FUCK at line \(#line)")
            data = []
        }
        // Do any additional setup after loading the view.
        
//        var dataStrs:[String] = []
        
        var goodTagStrs:[String] = []
        var badTagStrs:[String] = []
        
        for item in data{
            
            print("Begin process data... in MoreTagViewController at line \(#line)")
//            dataStrs.append(item.rawValue)
            if item.rawValue.contains("👍"){
                print("Good staff in... in MoreTagViewController at line \(#line)")
            
                var str = item.rawValue
                str.remove(at: str.startIndex)
                goodTagStrs.append(str)
            }else{
                
                 print("Bad staff in... in MoreTagViewController at line \(#line)")
                var str = item.rawValue
                str.remove(at: str.startIndex)
                badTagStrs.append(str)
            }
        }
        
        var goodDataSourceArr:[MoreTagItem] = []
        var badDataSourceArr:[MoreTagItem] = []
        
        
//        var good = Set(goodDataSourceArr)
        
        for str in goodTagStrs{
            print("Start to initial datasource with good. at line \(#line)")
            let count = getRepeatTimes(of: str, in: goodTagStrs)
            let item = MoreTagItem(title: str,bubleCount: count)
            if !goodDataSourceArr.contains(item){
                goodDataSourceArr.append(item)
            }
//            goodDataSourceArr.append(item)
        }
        for str in badTagStrs{
            let count = getRepeatTimes(of: str, in: badTagStrs)
            let item = MoreTagItem(title: str,bubleCount: count)
            if !badDataSourceArr.contains(item){
                badDataSourceArr.append(item)
            }
            
        }
        
//        let goodDataSource = MoreTagViewDataSource(dataSource: goodDataSourceArr)
//        self.BenifitCollectionView.dataSource = goodDataSource
        self.goodDataSource = goodDataSourceArr
        self.collectionView.dataSource = self
        
//        let badDataSource = MoreTagViewDataSource(dataSource: badDataSourceArr)
        
        self.badDataSource = badDataSourceArr
//        self.BadCollectionView.dataSource = badDataSource
//        self.BadCollectionView.dataSource = badDataSource
        
//        self.BadCollectionView.delegate = self
//        self.BenifitCollectionView.delegate = self
        
//        self.BenifitCollectionView.header
        
        //手指动作识别
        let downSwipeGesture = UISwipeGestureRecognizer()
        downSwipeGesture.direction = .down
        downSwipeGesture.addTarget(self, action: #selector(popSelfViewController(_:)))
        self.view.addGestureRecognizer(downSwipeGesture)
        
    }
    

    
    
    @IBAction func popSelfViewController(_ sender:UIScreenEdgePanGestureRecognizer){
//        navigationController?.popViewController(animated: true)
        HelperFunc.pop(navigationController: navigationController)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1{
            return self.badDataSource.count
        }else{
            return self.goodDataSource.count
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreTagViewCell", for: indexPath) as! MoreTagViewCell
        
        
        if indexPath.section == 1{
            
                cell.data = self.badDataSource[indexPath.row]
                
                
                cell.contentLabelOutline.backgroundColor = UIColor(red: 255/255, green: 235/255, blue: 238/255, alpha: 1)
//
//                cell.contentLabel.tintColor =  UIColor(red: 239/255, green: 83/255, blue: 80/255, alpha: 1)
            cell.contentLabel.textColor = UIColor(red: 239/255, green: 83/255, blue: 80/255, alpha: 1)
            
            
        }else{
            cell.data = self.goodDataSource[indexPath.row]
            
            
//            cell.contentLabelOutline.backgroundColor = UIColor(red: 239/255, green: 83/255, blue: 80/255, alpha: 1)
            
            cell.contentLabelOutline.backgroundColor = UIColor(red: 225/255, green: 245/255, blue: 254/255, alpha: 1)
//
            cell.contentLabel.textColor = UIColor(red: 41/255, green: 182/255, blue: 246/255, alpha: 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderCollectionReusableView
        if indexPath.section == 0{
            view.contentLabel.text = "👍"
        }else{
            view.contentLabel.text = "😩"
        }
        
        
        return view
    }
    
    


}
