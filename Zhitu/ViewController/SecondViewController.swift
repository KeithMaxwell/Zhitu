//
//  SecondViewController.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/5.
//  Copyright © 2020 maxwell. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate{
    
    
    

    @IBOutlet weak var trafficPickerView: UIPickerView!
    @IBOutlet weak var timePickerView: UIPickerView!
    
    
    @IBOutlet weak var typeStackView: UIStackView!
    @IBOutlet weak var typePickerView: UIPickerView!
    
    
    @IBOutlet weak var planStackView: UIStackView!
    @IBOutlet weak var planPicerView: UIPickerView!
    var trafficWays:[String] = ["驾车","火车","飞机","公交","步行","自行车"]
    var times:[String] = ["一小时内","一到三小时","三小时以上"]
    var types:[String] = ["全部","历史遗迹","名人故居","公园乐园","建筑人文","特色街区","影视城","宗教场所","民风民俗","自然风光","其他"]
    var planDays:[Int] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...14{
            planDays.append(i)
        }

        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        trafficPickerView.delegate = self
        timePickerView.delegate = self
        typePickerView.delegate = self
        planPicerView.delegate = self
        
        
        //手指识别
        let screenEdge = UIScreenEdgePanGestureRecognizer()
        screenEdge.addTarget(self, action: #selector(backGesture(_:)))
        self.view.addGestureRecognizer(screenEdge)
        
        let leftSwipeGesture = UISwipeGestureRecognizer()
        leftSwipeGesture.direction = .left
        leftSwipeGesture.addTarget(self, action: #selector(jumpToResultViewController(_:)))
        self.view.addGestureRecognizer(leftSwipeGesture)
        
        let downSwipeGesture = UISwipeGestureRecognizer()
        downSwipeGesture.direction = .down
        downSwipeGesture.addTarget(self, action: #selector(backBtnClicked(_:)))
        self.view.addGestureRecognizer(downSwipeGesture)
        
        
        
        
       
    }
    
    @objc func jumpToResultViewController(_ sender:UISwipeGestureRecognizer){
        
        
        //跳转前先判断是否还有内容可以显示。如果没有则不显示。
        if ItemList.sharedValue().list.count == 0{
            ItemList.moreData()
        }

        if let view = storyboard?.instantiateViewController(withIdentifier: "ResultViewController"){
            
            ResultViewController.resultDataList = ItemList.sharedValue().list
            navigationController?.pushViewController(view, animated: true)
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
    
    @objc func backGesture(_ sender:UIScreenEdgePanGestureRecognizer){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
//        navigationController?.popViewController(animated: true)
        HelperFunc.pop(navigationController: navigationController)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var count = 0
        
        switch pickerView {
        case trafficPickerView:
            count = trafficWays.count
        case timePickerView:
            count = times.count
        case typePickerView:
            count = types.count
        case planPicerView:
            count = planDays.count
        default:
            count = 1
        }
        
        return count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let lab = UILabel()
        switch pickerView {
        case trafficPickerView:
            lab.text = self.trafficWays[row]
            lab.sizeToFit()
        case timePickerView:
            lab.text = self.times[row]
            lab.sizeToFit()
        case typePickerView:
            lab.text = self.types[row]
            lab.sizeToFit()
        case planPicerView:
            lab.text = "\(self.planDays[row])"
            lab.sizeToFit()
        default:
            lab.sizeToFit()
            
        }
        
        return lab
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == self.trafficPickerView{
//            print(self.trafficWays[row])
//        }else{
//            print(self.times[row])
//        }
    }
    

    @IBAction func showMoreBtnClicked(_ sender: UIButton) {
        
        if let result = sender.titleLabel?.text?.contains("显示"),result{
            UIView.animate(withDuration: 0.5) {
                self.typeStackView.alpha = 1
                self.planStackView.alpha = 1
            }
             sender.setTitle("隐藏更多筛选条件", for: .normal)
        }else{
            UIView.animate(withDuration: 0.5) {
                self.typeStackView.alpha = 0
                self.planStackView.alpha = 0
            }
             sender.setTitle("显示更多筛选条件", for: .normal)
        }
        
       
        
        
    }
    
}


