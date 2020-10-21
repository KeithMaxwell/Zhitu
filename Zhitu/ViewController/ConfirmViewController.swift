//
//  ConfirmViewController.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/6.
//  Copyright © 2020 maxwell. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {

    @IBOutlet weak var starSuperView: UIView!
    @IBOutlet weak var starView1:UIImageView!
    @IBOutlet weak var starView2:UIImageView!
    @IBOutlet weak var starView3:UIImageView!
    @IBOutlet weak var starView4:UIImageView!
    @IBOutlet weak var starView5:UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var btnStackView: UIStackView!
    @IBOutlet weak var contentOutlineView: UIView!
    @IBOutlet weak var confirmTitleView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userLevelLb: UILabel!
    @IBOutlet weak var officialLevelLb: UILabel!
    @IBOutlet weak var addressLb: UILabel!
    
    var stars:[UIImageView]!
    
    var data:Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        stars = [starView1,starView2,starView3,starView4,starView5]
        if data == nil{
            data = Item()
            print("data is nil")
        }
        
        print("data is not nil")
        
        
        let starCount = HelperFunc.getStartCounts(item: data)
        
//        print("startcount=\(starCount) at \(#function) in \(#line)")
        
        for i in 0..<starCount{
            stars[i].image = UIImage(named: "star_full")
        }
        
        self.titleLabel.text = data.title
        self.officialLevelLb.text = "国家评级：\(data.officialLevel.rawValue)"
        self.userLevelLb.text = "用户评分：\(data.userLevel.rawValue)"
            
            
        self.addressLb.text = data.address
        
        
        
        

        // Do any additional setup after loading the view.
        
        HelperFunc.makeBorders(view: self.contentView)
        HelperFunc.makeShadows(view: self.contentView)
//        contentView.layer.borderWidth = 1
//        contentView.layer.borderColor = UIColor.gray.cgColor
//        contentView.layer.cornerRadius = 10
        
        animationBegins()
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func animationBegins(){
        
        
//        let y = self.confirmTitleView.frame.size.height
//        self.confirmTitleView.bounds.origin = CGPoint(x: 0, y: 3*y)
        
//        let contentOutlineViewY = self.contentOutlineView.frame.origin.y
//        let contentOutlineViewH = self.contentOutlineView.frame.size.height
//        self.contentOutlineView.bounds.origin = CGPoint(x: 0, y: contentOutlineViewY + contentOutlineViewH)
        
        HelperFunc.initBounds(view: self.contentOutlineView)
        HelperFunc.initBounds(view: self.btnStackView)
        
        
        
        HelperFunc.initTransform(views: stars)
        
        let anim = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) {
            
            //标题动画：改变透明度
            self.confirmTitleView.alpha = 1
//            self.confirmTitleView.bounds.origin = CGPoint(x: 0, y: 0)
        }
        
        
        anim.startAnimation()
        
        anim.addAnimations({
            HelperFunc.quiverAnimation(view: self.contentOutlineView)
            HelperFunc.quiverAnimation(view: self.btnStackView)
            HelperFunc.starAnimation(views: self.stars)
        }, delayFactor: 0.8)
        
        
        
        anim.addCompletion { (_) in
//            secondAnim.startAnimation()
            
            
            
//            self.starStackView.bounds.origin = CGPoint(x: 0, y: 252)
            
            
            

        }
       
        
        
        

    }
    
    
   
    @IBAction func backBtnClicked(_ sender: UIButton) {
//        navigationController?.popViewController(animated: true)
        HelperFunc.reverseDirectionPop(navigationController: navigationController)
    }
    
    
    @IBAction func confirmBtnClick(_ sender: Any) {
        if let view = storyboard?.instantiateViewController(identifier: "FeedBackViewController"){
            let v = view as! FeedBackViewController
            v.data = data
            
//            let data = ItemList.popItem()
            ItemList.removeDataFromSystemToUser(item: data)
            
            
            
            HelperFunc.push(viewController: v, navigationController: navigationController)
        }
    }
    
}
