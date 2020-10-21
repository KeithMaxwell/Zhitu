//
//  ResultViewController.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/6.
//  Copyright © 2020 maxwell. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController,UICollectionViewDelegate{
    
    
    /**管理策略：初始化viewCount为1，然后控制新建新的ResultViewController的
     方法在新建ResultViewController的时候viewCount+1
     
     */
    static var viewCount = 1 //通过这个viewCount静态变量来控制ResultViewController的个数，初始化为一个，且不能小于一个
    
    
    @IBOutlet weak var starView1: UIImageView!
    @IBOutlet weak var starView2: UIImageView!
    @IBOutlet weak var starView3: UIImageView!
    @IBOutlet weak var starView4: UIImageView!
    @IBOutlet weak var starView5: UIImageView!
    
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentOutlineView: UIView!
    @IBOutlet weak var tagsView: UIView!
    @IBOutlet weak var commentView: UIView!
    
    @IBOutlet weak var offitialLevel: UIView!
    
    @IBOutlet weak var userLevel: UIView!
    var stars:[UIImageView] = []
    
    
    
    //需要添加数据的控件
    //    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    //    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBOutlet weak var descriptionTv: UITextView!
    @IBOutlet weak var officialLevelLabel: UILabel!
    
    @IBOutlet weak var moreTagsBtn: UIButton!
    @IBOutlet weak var userLevelLb: UILabel!
    
    
    static var resultDataList:[Item]!
    
    var data:Item!
    
    /***********标签组件开始*********/
    
    @IBOutlet weak var moreTagsView: UIView!
    @IBOutlet weak var label1Content: UILabel!
    
    
    /**查看更多标签的按钮*/
    @IBOutlet weak var moreTagsLeftpart: UIStackView!
    
    @IBOutlet weak var label2Content: UILabel!
    
    
    @IBOutlet weak var label3Content: UILabel!
    
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var leftSwipeNoteBtn: UIButton!
    
    
    /***********标签组件结束*********/
    
    
    //    var collectionViewDataSource = ImageCollectionViewDatasource()
    
    //图片资源
    var collectionViewDataSourceArray = ItemList.sharedValue().getCollectionViewDatasources()
    
    //图片个数
    var imageCount = 0
    
    
    func UIInitial(){
        
        if ResultViewController.resultDataList == nil{
            ResultViewController.resultDataList = ItemList.sharedValue().list
            
        }
        
        var index = ResultViewController.viewCount - 1
        if index >= ResultViewController.resultDataList.count{
            index = 0
        }
        
        let resultData = ResultViewController.resultDataList[index]
        self.data = resultData
        
        stars.append(starView1)
        stars.append(starView2)
        stars.append(starView3)
        stars.append(starView4)
        stars.append(starView5)
        
        let starCount = HelperFunc.getStartCounts(item: resultData)
        
        for i in 0..<starCount{
            stars[i].image = UIImage(named: "star_full")
        }
        
        titleLabel.text = resultData.title
        //        resultImageView.image = UIImage(named: resultData.imageName)
        descriptionTv.text = resultData.description
        officialLevelLabel.text = resultData.officialLevel.rawValue
        userLevelLb.text = resultData.userLevel.rawValue
        
        
        
        
        let tagLabels = [label1Content,label2Content,label3Content]
        
        
        
        for item in tagLabels{
            item?.alpha = 0
        }
        noteLabel.alpha = 0
        
        switch resultData.tags.count {
        case 0:
            print("0")
            fallthrough
        case 1:
            print("1 at \(#function)")
            
            if !resultData.tags.isEmpty{
                self.label1Content.text = self.data.tags[0].rawValue
                self.label1Content.alpha = 1
                print("resultData.tags is not empty int ResultViewController at \(#line)")
            }
            
            self.noteLabel.alpha = 1
        case 2:
            
            print("2 in \(#function) at \(#line)")
            fallthrough
        case 3:
            print("3 in \(#function) at \(#line)")
            fallthrough
            
        default:
            for i in 0..<resultData.tags.count{
                if i > 2{
                    break
                }
                tagLabels[i]?.alpha = 1
                tagLabels[i]?.text = resultData.tags[i].rawValue
                
            }
            leftSwipeNoteBtn.addTarget(self, action: #selector(leftSwipeByBtn(_:)), for: .touchUpInside)
            print("default")
        }
        
        moreTagsBtn.addTarget(self, action: #selector(moreTagsBtnClicked(_:)), for: .touchUpInside)
        
        
        if ResultViewController.resultDataList.count == ResultViewController.viewCount{
            leftSwipeNoteBtn.setTitle("都不满意？添加新的条件吧！", for: .normal)
            leftSwipeNoteBtn.addTarget(self, action: #selector(moreCondition(_:)), for: .touchUpInside)
        }
        
        //        self.tableView.dataSource = self
        //        self.tableView.delegate = self
        //
        //        self.tableView.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI/2))
        //        self.tableView.transform = CGAffineTransform(scaleX: 1, y: 1)
        
        let dataSource = collectionViewDataSourceArray[ResultViewController.viewCount-1]
        self.collectionView.dataSource = dataSource
        self.collectionView.delegate = self
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
        self.imageCount =  dataSource.datasource.count
        
        self.collectionView.allowsMultipleSelection = false
        
    }
    
    
    //
    //    func processTagsView(){
    //
    //    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIInitial()
        
        //        self.contentView.layer.shadowOffset
        //        self.contentView.layer.shadowColor = UIColor.gray.cgColor
        //        self.contentView.layer.shadowRadius = 2
        //        self.contentView.layer.shadowOffset = CGSize(width: 3, height: 3)
        //        self.contentView.layer.shadowOpacity = 0.8
        
        //        self.contentView.shadow(type: .all, color: .gray, opactiy: 0.5, shadowSize: 2)
        
        
        
        //        ResultViewController.viewCount += 1
        
        //        print("ResultViewDidLoad plus,viewCount = \(ResultViewController.viewCount)******************* in \(#function)")
        
        //        UIInitial()
        // Do any additional setup after loading the view.
        HelperFunc.makeBorders(view: self.offitialLevel)
        HelperFunc.makeBorders(view: self.userLevel)
        HelperFunc.makeBorders(view: self.contentView)
        
        HelperFunc.makeShadows(view: self.contentView)
        HelperFunc.makeShadows(view: self.userLevel)
        HelperFunc.makeShadows(view: self.offitialLevel)
        animationsBegin()
        
        //手指动作识别代码部分
        
//        let screenEdgePanGesture = UIScreenEdgePanGestureRecognizer()
//        screenEdgePanGesture.edges = .left
//        
//        screenEdgePanGesture.addTarget(self, action: #selector(rightSwipePopSelf(_:)))
//        self.view.addGestureRecognizer(screenEdgePanGesture)
        
        //用于在结果中前进
        let leftSwipeGesture = UISwipeGestureRecognizer()
        leftSwipeGesture.direction = .left
        leftSwipeGesture.addTarget(self, action: #selector(pushAnotherResultViewController(_:)))
        
        self.view.addGestureRecognizer(leftSwipeGesture)
        
        //用于在结果中回退
        let rightSwipeGesture = UISwipeGestureRecognizer()
        rightSwipeGesture.direction = .right
        rightSwipeGesture.addTarget(self, action: #selector(rightSwipePopSelf(_:)))
        self.view.addGestureRecognizer(rightSwipeGesture)
        
        //用于进入确认界面
        let upSwipeGesture = UISwipeGestureRecognizer()
        upSwipeGesture.direction = .down
        upSwipeGesture.addTarget(self, action: #selector(jumpToComfirmViewBtn(_:)))
        self.view .addGestureRecognizer(upSwipeGesture)
        
        
        let downSwipeGesture = UISwipeGestureRecognizer()
        downSwipeGesture.direction = .up
        downSwipeGesture.addTarget(self, action: #selector(moreTagsBtnClicked(_:)))
        self.view.addGestureRecognizer(downSwipeGesture)
        
        
        //        self.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
        
        //        self.scrollToNextImage(self)
                let timer = Timer(timeInterval: 3.5, target: self, selector: #selector(scrollToNextImage(_:)), userInfo: nil, repeats: true)
                RunLoop.main.add(timer, forMode: .default)
    }
    
    
    
    @IBAction func buttonCliced(_ sender: Any) {
        //        scrollToNextImage(sender)
    }
    
    /**用于将自己从屏幕中清除。该类中只有这一个popSelf方法。*/
    @objc func popSelfController(_ sender:UIScreenEdgePanGestureRecognizer?){
        
        //viewCount 减少一
        ResultViewController.viewCount -= 1
        
        //如果当前ResultViewController是第一个ResultViewController，则viewCount重置为初始值。
        if ResultViewController.viewCount == 0{
            ResultViewController.viewCount = 1
        }
        
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func rightSwipePopSelf(_ sender:Any){
        if ResultViewController.viewCount > 1{
            popSelfController(nil)
        }
    }
    
    
    /**用于新建一个ResultViewController。这是改类中唯一从自身创建另一个ResultViewController的方法。*/
    @objc func pushAnotherResultViewController(_:UISwipeGestureRecognizer?){
        if let view = storyboard?.instantiateViewController(withIdentifier: "ResultViewController"){
            
            //viewCount加1
            ResultViewController.viewCount += 1
            //            let v = view as! ResultViewController
            
            //保证只会创建数据集合中数据个数个ResultViewController
            if ResultViewController.viewCount > ResultViewController.resultDataList.count{
                ResultViewController.viewCount -= 1
                return
            }
            
            navigationController?.pushViewController(view, animated: true)
        }
        
    }
    
    //    func makeBorders(view:UIView){
    //        view.layer.borderWidth = 1
    //        view.layer.borderColor = UIColor.gray.cgColor
    //
    //        let width = view.frame.size.width
    //        view.layer.cornerRadius = width / 20
    //    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func animationsBegin(){
        
        
        HelperFunc.initTransform(views: stars)
        HelperFunc.starAnimation(views: stars)
        
        HelperFunc.initBounds(view: self.contentOutlineView)
        HelperFunc.initBounds(view: self.commentView)
        HelperFunc.quiverAnimation(view: self.contentOutlineView)
        HelperFunc.quiverAnimation(view: self.commentView){
            UIView.animate(withDuration: 2, animations: {
                self.tagsView.alpha = 1
            }, completion: nil)
        }
        
        
        let anim = UIViewPropertyAnimator(duration: 2, curve: .easeIn) {
            self.moreTagsView.alpha = 1
            UIView.performWithoutAnimation {
                
                //如果tag数目小于等于三，则屏幕完全可以显示出来所有便签，则不需要有查看更多标签的button
                if self.data.tags.count <= 3{
                    self.moreTagsLeftpart.alpha = 0
                }
                
            }
        }
        anim.startAnimation(afterDelay: 3)
        
        
    }
    
    @objc func leftSwipeByBtn(_ sender:UIButton){
        pushAnotherResultViewController(nil)
    }
    
    
    @objc func moreCondition(_ sender:UIButton){
        navigationController?.popToRootViewController(animated: true)
        
        jumpToSecondViewController()
        
    }
    
    func jumpToSecondViewController(){
        if let view = storyboard?.instantiateViewController(identifier: "secondViewController"){
            
            navigationController?.pushViewController(view, animated: true)
            ResultViewController.viewCount = 1
        }
    }
    

    @objc func moreTagsBtnClicked(_ sender:Any){
        
        if self.data.tags.count <= 3{
            return
        }
        
        if let view = storyboard?.instantiateViewController(withIdentifier: "MoreTagViewController"){
            let v = view as! MoreTagViewController
            v.data = self.data.tags
            HelperFunc.push(viewController: view, navigationController: navigationController)
            
            //            navigationController?.pushViewController(view, animated: true)
        }
        
        
    }
    
    @IBAction func jumpToComfirmViewBtn(_ sender: Any) {
        if let view = storyboard?.instantiateViewController(withIdentifier: "ConfirmViewController"){
            let v = view as! ConfirmViewController
            v.data = self.data
            
            //            navigationController?.pushViewController(v, animated: true)
            //            HelperFunc.push(viewController: v, navigationController: navigationController)
            HelperFunc.reverseDirectionPush(viewController: v, navigationController: navigationController)
        }
        
        
        
    }
    
    
    
    @objc func scrollToNextImage(_ sender: Any) {
        if let indexPath = self.collectionView.indexPathsForVisibleItems.first{
            var row = indexPath.row
            row += 1
            if row > self.imageCount{
                row = 0
            }
            
            let anotherIndexPath = IndexPath(row: row, section: 0)
            
            self.collectionView.scrollToItem(at: anotherIndexPath, at: .centeredHorizontally, animated: true)
            
        }
        
        
    }
    
}
