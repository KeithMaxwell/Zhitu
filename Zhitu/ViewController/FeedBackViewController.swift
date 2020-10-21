//
//  FeedBackViewController.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/6.
//  Copyright © 2020 maxwell. All rights reserved.
//

import UIKit

class FeedBackViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    
    @IBOutlet var animationView: [UIView]!
    
    
    
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var levelView: UIView!
    
    @IBOutlet weak var levelViewOutlineView: UIView!
    @IBOutlet weak var levelPicker: UIPickerView!
    
    @IBOutlet weak var tagPicker: UIPickerView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var officialLevelLabel: UILabel!
    
    @IBOutlet weak var userLevelLabel: UILabel!
    
    
    @IBOutlet weak var addTagsBtn: UIButton!
    
    /**用于判断tagPicker是否已经被修改*/
    private var tagPickerViewIsModified = false
    
    /**用于判断levelPicker是否已经被修改*/
    private var levelPickerViewIsModified = false
    
    var stars: [UIImageView]!
    
    var levelPickerData:[String] = ["AAAAA","AAAA","AAA","AA","A"]
    var tagLevelPickerData:[String] = []
    
    
    var data:Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in animationView{
            view.alpha = 0
        }
        
        tagLevelPickerData = Tag.getAllTagsOfStr()
        
        if data == nil{
            data = Item()
        }
        
        stars = [star1,star2,star3,star4,star5]
        
        let starCounts = HelperFunc.getStartCounts(item: data)
        
        for i in 0..<starCounts{
            stars[i].image = UIImage(named: "star_full")
        }
        
        self.titleLabel.text = data.title
        self.officialLevelLabel.text = "国家评级：\(data.officialLevel.rawValue)"
        self.userLevelLabel.text = "用户评价：\(data.userLevel.rawValue)"
        

        self.addTagsBtn.addTarget(self, action: #selector(addBtnClicked(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
        
        
        HelperFunc.makeBorders(view: levelView)
        HelperFunc.makeShadows(view: levelView)
        
        levelPicker.delegate = self
        tagPicker.delegate = self
        startAnimation()
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func startAnimation(){
        
        HelperFunc.initTransform(views: stars)
//        HelperFunc.initBounds(view: self.levelViewOutlineView)
        HelperFunc.initTransform(views: [self.levelViewOutlineView])
        let anim = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {
            
            for view in self.animationView{
                 view.alpha = 1
            }
           
        }
        anim.addAnimations({
            HelperFunc.starAnimation(views: self.stars)
            HelperFunc.quiverAnimationByTransform(view: self.levelViewOutlineView,duration:0.7)
        }, delayFactor: 1)
        
        
        anim.startAnimation()
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let lab = UILabel()
        if pickerView == self.levelPicker{
            
            lab.text = levelPickerData[row]
            
        }else{
            lab.text = tagLevelPickerData[row]
        }
        return lab
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        if pickerView == self.levelPicker{
            
            count = self.levelPickerData.count
            
        }else{
            count = self.tagLevelPickerData.count
        }
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == self.levelPicker{
            
            levelPickerViewIsModified = true

        }else{
             tagPickerViewIsModified = true
        }
        
       
        
    }
    
    func jumpToVisitedViewController(){
        if let view = storyboard?.instantiateViewController(identifier: "VisitedPlaceViewController"){
//            let v = view as! VisitedPlaceViewController
//            v.dataList = ResultViewController.resultDataList
            navigationController?.pushViewController(view, animated: true)
        }
    }
    
    @objc func addBtnClicked(_ sender:Any){
        let index = self.tagPicker.selectedRow(inComponent: 0)
        if tagLevelPickerData.count == 0{
            (sender as! UIButton).isHidden = true
            return
        }
        let rawValue = tagLevelPickerData.remove(at: index)
        if let tag = Tag(rawValue: rawValue){
                ItemList.modifify(item: data, ofProperty: .tag, newValue: tag)
        }
        
        tagPicker.reloadComponent(0)
        
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        let index1 = self.levelPicker.selectedRow(inComponent: 0)
        let rawvalue = levelPickerData[index1]
        if let level = Level(rawValue:rawvalue){
            if levelPickerViewIsModified{
                ItemList.modifify(item: data, ofProperty: .level,newValue: level)
            }else{
                if data.userLevel == .none{
                    ItemList.modifify(item: data, ofProperty: .level, newValue: Level.none)
                }
                
            }
            
        }
        
//        //        let yes = tagPicker.
//        let index2 = self.tagPicker.selectedRow(inComponent: 0)
//        let rawvalue2 = tagLevelPickerData[index2]
//        if let tag = Tag(rawValue: rawvalue2){
//            if tagPickerViewIsModified{
//                ItemList.modifify(item: data, ofProperty: .tag, newValue: tag)
//            }else{
//                ItemList.modifify(item: data, ofProperty: .tag, newValue: [])
//            }
//
//        }
        jumpToVisitedViewController()
    }
    
    @IBAction func confirmBtnClicked(_ sender: Any) {
        
        if tagLevelPickerData.count <= 0 || levelPickerData.count <= 0{
            jumpToVisitedViewController()
            return
        }
        
        let index1 = self.levelPicker.selectedRow(inComponent: 0)
        let rawvalue = levelPickerData[index1]
        if let level = Level(rawValue:rawvalue){
            ItemList.modifify(item: data, ofProperty: .level,newValue: level)
        }
//        let index2 = self.tagPicker.selectedRow(inComponent: 0)
//        let rawvalue2 = tagLevelPickerData[index2]
//        if let tag = Tag(rawValue: rawvalue2){
//
//                ItemList.modifify(item: data, ofProperty: .tag, newValue: tag)
//           }
        jumpToVisitedViewController()
    }
    
    
}
