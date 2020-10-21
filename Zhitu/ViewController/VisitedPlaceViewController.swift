//
//  VisitedPlaceViewController.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/7.
//  Copyright © 2020 maxwell. All rights reserved.
//

import UIKit

class VisitedPlaceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    
    
    
    
    @IBOutlet weak var noteLabel1: UILabel! //快去地图上插满旗帜吧
    @IBOutlet weak var noteLabel2: UILabel! //点击卡片去修改评价吧！
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //    var data:Item!
    
    var dataList:[Item]!
    
    var anim:UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.showsVerticalScrollIndicator = false
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        print("success")
        
        
        if dataList == nil{
            dataList = ItemList.sharedValue().userContentList
            
        }
        //        dataList = ResultViewController.resultDataList
        
        startAnimation()
        
        //手指动作识别
        let rightSwipeGesture = UISwipeGestureRecognizer()
        rightSwipeGesture.direction = .right
        rightSwipeGesture.addTarget(self, action: #selector(jumpToFirstViewController(_:)))
        self.view.addGestureRecognizer(rightSwipeGesture)
        
//        self.tableView.scrollToRow(at: IndexPath(row: dataList.count-1, section: 0), at: .bottom, animated: true)
        print(dataList.count)
        
    }
    
    func startAnimation(){
        self.tableView.alpha = 0
        HelperFunc.initTransfromForView(view: tableView)
        anim = UIViewPropertyAnimator(duration: 0.8, curve: .easeIn) {
            self.noteLabel1.alpha = 1
            self.noteLabel2.alpha = 1
        }
        
        
        anim.startAnimation()
        
        anim.addCompletion { _ in
            self.tableView.alpha = 1
            HelperFunc.quiverAnimationByTransformFromLeftToRight(view: self.tableView)
            
            UIView.animate(withDuration: 1, delay: 2, options: .curveEaseIn, animations: {
                self.noteLabel2.alpha = 0
            }){_ in
                
            }
//            { (_) in
//                self.noteLabel2.text = "下滑卡片以查看更多哦！"
//                UIView.animate(withDuration: 1,animations: {
//                    self.noteLabel2.alpha = 1
//                }){ _ in
//
//                    UIView.animate(withDuration: 1, delay: 2, options: .curveEaseIn, animations: {
//                        self.noteLabel2.alpha = 0
//                    }) { (_) in
//                        self.noteLabel2.text = "点击卡片去修改评价吧！"
//                        UIView.animate(withDuration: 1,animations: {
//                            self.noteLabel2.alpha = 1
//                        })
//                    }
//                }
//                
//                //            UIView.animate(withDuration: 1, animations: {
//                //
//                //            }) { (_) in
//                //
//                //                }
//            }
            self.tableView.scrollToRow(at: IndexPath(row: self.dataList.count-1, section: 0), at: .middle, animated: false)
            
            
        }
        
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //          print(dataList.count)
        return dataList.count
    }
    
    //      func numberOfSections(in tableView: UITableView) -> Int {
    //          return 1
    //      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"tagCell")!
        
        let c = cell as! TagCell
        c.data = dataList[indexPath.row]
        //        c.no = indexPath.row
        //        TagCell.cellNum = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //当某一个cell被选中时，跳转到对应界面
        let data = self.dataList[indexPath.row]
        jumpToFeedBackViewController(item: data)
    }
    
    
    //    @objc func popSelf(_ sender:Any){
    //        TagCell.cellNo = -1
    //        navigationController?.popViewController(animated: true)
    //    }
    
    @objc func jumpToFirstViewController(_ sender:Any){
        anim.stopAnimation(false)
        ResultViewController.viewCount = 1
        //        TagCell.cellNo = -1
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    func jumpToFeedBackViewController(item:Item){
        if let view = storyboard?.instantiateViewController(identifier: "FeedBackViewController"){
            let v = view as! FeedBackViewController
            v.data = item
            navigationController?.pushViewController(view, animated: true)
        }
    }
    
    
    
}
