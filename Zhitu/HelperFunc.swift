//
//  HelperFunc.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/6.
//  Copyright © 2020 maxwell. All rights reserved.
//

import UIKit

extension UIView {
    enum ShadowType: Int {
        case all = 0 ///四周
        case top  = 1 ///上方
        case left = 2///左边
        case right = 3///右边
        case bottom = 4///下方
    }
    
    ///默认设置：黑色阴影, 阴影所占视图的比例
    // func shadow(_ type: ShadowType, percent: Float) {
        // shadow(type: type, color: .black, opactiy: 0.4, //shadowSize: 4)
     //}
     ///默认设置：黑色阴影
    func shadow(_ type: ShadowType) {
        shadow(type: type, color: .black, opactiy: 0.4,shadowRadius: 10, shadowSize: 4)
     }
     ///常规设置
    func shadow(type: ShadowType, color: UIColor,  opactiy: Float,shadowRadius: CGFloat,shadowSize: CGFloat) -> Void {
         layer.masksToBounds = false;//必须要等于NO否则会把阴影切割隐藏掉
         layer.shadowColor = color.cgColor;// 阴影颜色
         layer.shadowOpacity = opactiy;// 阴影透明度，默认0
         layer.shadowOffset = .zero;//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
         layer.shadowRadius = shadowRadius //阴影半径，默认3
         var shadowRect: CGRect?
         switch type {
         case .all:
             shadowRect = CGRect.init(x: -shadowSize, y: -shadowSize, width: bounds.size.width + 2 * shadowSize, height: bounds.size.height + 2 * shadowSize)
         case .top:
             shadowRect = CGRect.init(x: -shadowSize, y: -shadowSize, width: bounds.size.width + 2 * shadowSize, height: 2 * shadowSize)
         case .bottom:
             shadowRect = CGRect.init(x: -shadowSize, y: bounds.size.height - shadowSize, width: bounds.size.width + 2 * shadowSize, height: 2 * shadowSize)
         case .left:
             shadowRect = CGRect.init(x: -shadowSize, y: -shadowSize, width: 2 * shadowSize, height: bounds.size.height + 2 * shadowSize)
         case .right:
             shadowRect = CGRect.init(x: bounds.size.width - shadowSize, y: -shadowSize, width: 2 * shadowSize, height: bounds.size.height + 2 * shadowSize)
         }
         layer.shadowPath = UIBezierPath.init(rect: shadowRect!).cgPath
     }
}

class HelperFunc: NSObject {
    
    
    
    
    
    /**用于初始化View的bounds为刚好隐藏的状态，为下一步动画作准备。*/
    public static func initBounds(view:UIView){
        let y = view.frame.origin.y
        let height = view.frame.size.height
        //前提为这个view的superview是屏幕的根view
        view.bounds.origin = CGPoint(x: 0,y: y+height)  //设置view相对自己的位置向上 y+height距离可以刚好隐藏这个view
    }
    
    /**用于初始化View数组的transfrom为刚好隐藏的状态，为下一步动画作准备。*/
    public static func initTransform(views:[UIView]){
        for view in views{
            var height:CGFloat = 0
            var superView:UIView? = view
            while superView != nil{
                height += superView!.frame.origin.y
                superView = superView?.superview
            }
            height += view.frame.size.height
            view.transform = CGAffineTransform(translationX: 0, y: -height)
            
        }
    }
    
    /**用于初始化View的transfrom为刚好隐藏的状态，为下一步动画作准备。*/
    public static func initTransform(view:UIView){
            var height:CGFloat = 0
            var superView:UIView? = view
            while superView != nil{
                height += superView!.frame.origin.y
                superView = superView?.superview
            }
            height += view.frame.size.height
            view.transform = CGAffineTransform(translationX: 0, y: -height)
    }
    
    /**横向动画准备工作。*/
    public static func initTransfromForView(view:UIView){
        var width:CGFloat = 0
        var superView:UIView? = view
        while superView != nil{
            width += superView!.frame.origin.x
            superView = superView?.superview
        }
        
        width += view.frame.size.width
        view.transform = CGAffineTransform(translationX: -width, y: 0)
    }
    
    
    /**颤抖动画，配合bounds使用，调用前必须调用initBounds(view:)方法，否则会造成错位*/
    public static func quiverAnimation(view:UIView,_ complition:(()->Void)? = nil ){
           
           
           let firstAnim = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
               view.bounds.origin = CGPoint(x: 0,y: -10)
           }
           let secondAnim = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
               view.bounds.origin = CGPoint(x: 0, y: 10)
           }
           
           let thirdAnim = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
                      view.bounds.origin = CGPoint(x: 0, y: -5)
                  }
           
           let fourthAnim = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
               view.bounds.origin = CGPoint(x: 0, y: 0)
           }
           
           firstAnim.startAnimation()
           
           
           firstAnim.addCompletion { (_) in
               secondAnim.startAnimation()
           }
           secondAnim.addCompletion { (_) in
               thirdAnim.startAnimation()
           }
           thirdAnim.addCompletion { (_) in
               fourthAnim.startAnimation()
           }
           fourthAnim.addCompletion { (_) in
            if let completion = complition{
                completion()
            }
           }
       }
    
    /**颤抖动画，配合transfrom使用，调用前必须调用initTransform(views:)方法或initTransfrom(view:)方法，否则会造成错位*/
    public static func quiverAnimationByTransform(view:UIView,_ complition:(()->Void)? = nil ){
        let firstAnim = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
//            view.bounds.origin = CGPoint(x: 0,y: -10)
            view.transform = CGAffineTransform(translationX: 0, y: 10)
            
        }
        let secondAnim = UIViewPropertyAnimator(duration: 0.1, curve: .easeInOut) {
//            view.bounds.origin = CGPoint(x: 0, y: 10)
            view.transform = CGAffineTransform(translationX: 0, y: -10)
        }
        
        let thirdAnim = UIViewPropertyAnimator(duration: 0.1, curve: .linear) {
//                   view.bounds.origin = CGPoint(x: 0, y: -5)
            view.transform = CGAffineTransform(translationX: 0, y: 5)
               }
        
        let fourthAnim = UIViewPropertyAnimator(duration: 0.1, curve: .linear) {
//            view.bounds.origin = CGPoint(x: 0, y: 0)
            view.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        
        firstAnim.startAnimation()
        
        
        firstAnim.addCompletion { (_) in
            secondAnim.startAnimation()
        }
        secondAnim.addCompletion { (_) in
            thirdAnim.startAnimation()
        }
        thirdAnim.addCompletion { (_) in
            fourthAnim.startAnimation()
        }
        fourthAnim.addCompletion { (_) in
         if let completion = complition{
             completion()
         }
        }
    }
    
    /**颤抖动画，配合transfrom使用，调用前必须调用initTransform(views:)方法或initTransfrom(view:)方法，否则会造成错位*/
    public static func quiverAnimationByTransform(view:UIView,duration:Double, _ complition:(()->Void)? = nil ){
        
        
        
        let time1 = duration
        let time2 = time1 / 2
        
            let firstAnim = UIViewPropertyAnimator(duration: time1, curve: .easeInOut) {
    //            view.bounds.origin = CGPoint(x: 0,y: -10)
                view.transform = CGAffineTransform(translationX: 0, y: 10)
                
            }
            let secondAnim = UIViewPropertyAnimator(duration: time2, curve: .easeInOut) {
    //            view.bounds.origin = CGPoint(x: 0, y: 10)
                view.transform = CGAffineTransform(translationX: 0, y: -10)
            }
            
            let thirdAnim = UIViewPropertyAnimator(duration: time2, curve: .linear) {
    //                   view.bounds.origin = CGPoint(x: 0, y: -5)
                view.transform = CGAffineTransform(translationX: 0, y: 5)
                   }
            
            let fourthAnim = UIViewPropertyAnimator(duration: time2, curve: .linear) {
    //            view.bounds.origin = CGPoint(x: 0, y: 0)
                view.transform = CGAffineTransform(translationX: 0, y: -5)
            }
        
            
            
            firstAnim.startAnimation()
            
            
            firstAnim.addCompletion { (_) in
                secondAnim.startAnimation()
            }
            secondAnim.addCompletion { (_) in
                thirdAnim.startAnimation()
            }
            thirdAnim.addCompletion { (_) in
                fourthAnim.startAnimation()
            }
            fourthAnim.addCompletion { (_) in
                UIView.animate(withDuration: time2, animations: {
                    view.transform = CGAffineTransform(translationX: 0, y: 0)
                }) { (_) in
                    if let completion = complition{
                        completion()
                    }
                }
             
            }
        }
    
    
    /**颤抖动画，配合transfrom使用，调用前必须调用initTransform(views:)方法或initTransfrom(view:)方法，否则会造成错位*/
    public static func quiverAnimationByTransform(view:UIView,duration:Double,delay:Double){
        
        let time1 = duration
        let time2 = time1 / 2
        
            let firstAnim = UIViewPropertyAnimator(duration: time1, curve: .easeInOut) {
    //            view.bounds.origin = CGPoint(x: 0,y: -10)
                view.transform = CGAffineTransform(translationX: 0, y: 10)
                
            }
            let secondAnim = UIViewPropertyAnimator(duration: time2, curve: .easeInOut) {
    //            view.bounds.origin = CGPoint(x: 0, y: 10)
                view.transform = CGAffineTransform(translationX: 0, y: -10)
            }
            
            let thirdAnim = UIViewPropertyAnimator(duration: time2, curve: .linear) {
    //                   view.bounds.origin = CGPoint(x: 0, y: -5)
                view.transform = CGAffineTransform(translationX: 0, y: 5)
                   }
            
            let fourthAnim = UIViewPropertyAnimator(duration: time2, curve: .linear) {
    //            view.bounds.origin = CGPoint(x: 0, y: 0)
                view.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
        firstAnim.startAnimation(afterDelay: delay)
        
            
            
            firstAnim.addCompletion { (_) in
                secondAnim.startAnimation()
            }
            secondAnim.addCompletion { (_) in
                thirdAnim.startAnimation()
            }
            thirdAnim.addCompletion { (_) in
                fourthAnim.startAnimation()
            }
            fourthAnim.addCompletion { (_) in
                
            }
        }
    
    
    
    public static func quiverAnimationByTransformFromLeftToRight(view:UIView,_ complition:(()->Void)? = nil ){
         let firstAnim = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
        //            view.bounds.origin = CGPoint(x: 0,y: -10)
                    view.transform = CGAffineTransform(translationX: 20, y: 0)
                    
                }
                let secondAnim = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
        //            view.bounds.origin = CGPoint(x: 0, y: 10)
                    view.transform = CGAffineTransform(translationX: -20, y: 0)
                }
                
                let thirdAnim = UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
        //                   view.bounds.origin = CGPoint(x: 0, y: -5)
                    view.transform = CGAffineTransform(translationX: 20, y: 0)
                       }
                
                let fourthAnim = UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
        //            view.bounds.origin = CGPoint(x: 0, y: 0)
                    view.transform = CGAffineTransform(translationX: -10, y: 0)
                }
                
                firstAnim.startAnimation()
                
                
                firstAnim.addCompletion { (_) in
                    secondAnim.startAnimation()
                }
                secondAnim.addCompletion { (_) in
                    thirdAnim.startAnimation()
                }
                thirdAnim.addCompletion { (_) in
                    fourthAnim.startAnimation()
                }
                fourthAnim.addCompletion { (_) in
                    UIView.animate(withDuration: 0.2, animations: {
                        view.transform = CGAffineTransform(translationX: 10, y: 0)
                    }) { (_) in
                        UIView.animate(withDuration: 0.2, animations: {
                            view.transform = CGAffineTransform(translationX: 0, y: 0)
                        }) { (_) in
                            if let completion = complition{
                                completion()
                            }
                        }
                    }
                }
        
        
    }
    
    /**专门给5个星星设置的动画，只能有五个控件*/
    public static func starAnimation(views:[UIView],delay:Double? = nil){
        if views.count != 5{    //仅支持只有5个星星的动画哦
            print("Not support")
            return
        }
        print("begin")
        
        let duration = 0.4
        
        let d = delay ?? 0
        
        quiverAnimationByTransform(view: views[0],duration:duration,delay:d)
        quiverAnimationByTransform(view: views[1],duration:duration,delay:0.2)
        quiverAnimationByTransform(view: views[2],duration:duration,delay:0.3)
        quiverAnimationByTransform(view: views[3],duration:duration,delay:0.4)
        quiverAnimationByTransform(view: views[4],duration:duration,delay:0.5)
        
        
        
        
//        let y = sup.frame.origin.y
//        let height = sup.frame.size.height
//        for view in views{
//            view.bounds.origin = CGPoint(x: 0, y: height + y)
//        }
        
    }
    
    public static func getStartCounts(item data:Item) -> Int{
        let level = data.officialLevel
        var starCount = 0
        
        switch level {
        case .A:
            starCount = 1
        case .AA:
            starCount = 2
        case .AAA:
            starCount = 3
        case .AAAA:
            starCount = 4
        case .AAAAA:
            starCount = 5
        case .none:
            starCount = 0
        
        }
        
        return starCount
    }
    
    static func push(viewController vc:UIViewController,navigationController nc:UINavigationController?){
        let transtion:CATransition = CATransition()
        transtion.duration = 0.4
        transtion.type = .moveIn
        transtion.subtype = .fromTop
        
        nc?.view.layer.add(transtion, forKey: kCATransition)
        nc?.pushViewController(vc, animated: false)
    }
    
    static func pop(navigationController nc:UINavigationController?){
        let transition = CATransition()
        
        transition.duration = 0.4
        transition.type = .reveal
        transition.subtype = .fromBottom
        nc?.view.layer.add(transition, forKey: kCATransition)
        nc?.popViewController(animated: false)
    }
    
    static func reverseDirectionPush(viewController vc:UIViewController,navigationController nc:UINavigationController?){
        let transtion:CATransition = CATransition()
        transtion.duration = 0.4
        transtion.type = .reveal
        transtion.subtype = .fromBottom
        
        nc?.view.layer.add(transtion, forKey: kCATransition)
        nc?.pushViewController(vc, animated: false)
    }
    
    static func reverseDirectionPop(navigationController nc:UINavigationController?){
        let transition = CATransition()
        
        transition.duration = 0.4
        transition.type = .moveIn
        transition.subtype = .fromTop
        nc?.view.layer.add(transition, forKey: kCATransition)
        nc?.popViewController(animated: false)
    }
    
    
    static func makeBorders(view:UIView){
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
//        UIColor.lightGray
        
        let width = view.frame.size.width
        view.layer.cornerRadius = width / 20
    }
    
    static func makeShadows(view:UIView){
//        let width = view.frame.size.width
        
//        view.shadow(type: .all, color: .lightGray, opactiy: 0.1, shadowRadius: width/20, shadowSize: 0.01)
        
        view.layer.shadowColor = UIColor.lightGray.cgColor
//        view.layer.shadowRadius = width / 20
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 5,height: 5)
    }

//    class ViewController: UIViewController {
//        @IBAction func typeChange(_ sender: UISegmentedControl) {
//            let myView = view.viewWithTag(10000)
//            myView?.shadow(UIView.ShadowType(rawValue: sender.selectedSegmentIndex)!)
//        }
//        
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            // Do any additional setup after loading the view.
//            let itemView = UIView.init(frame: CGRect.init(x: 100, y: 120, width: 100, height: 100))
//            itemView.backgroundColor = .red
//            itemView.shadow(.all)
//            itemView.tag = 10000
//            view.addSubview(itemView)
//        }
//    
//    
//    }
    
    
    
        
    
}
