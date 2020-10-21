//
//  ViewController.swift
//  Zhitu
//
//  Created by 胡晗 on 2020/7/5.
//  Copyright © 2020 maxwell. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController,MKMapViewDelegate{
    
    @IBOutlet weak var greetingLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var memoryStackView: UIStackView!
    
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var callBackMemoryBtn: UIButton!
    
    @IBOutlet weak var content: UIView!
    
    var longitude:Double!
    var latitude:Double!
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        if let title = view.annotation?.title{
//            print(title!)
//        }
        
        jumpToVisitedViewController(self)
//        view.setSelected(false, animated: false)
//        view.isSelected = false
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let id = MKMapViewDefaultAnnotationViewReuseIdentifier
        
        let v = mapView.dequeueReusableAnnotationView(withIdentifier: id,for: annotation) as! MKMarkerAnnotationView
        v.markerTintColor = .systemBlue
        
        return v
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (self.longitude,self.latitude) = getCoordinate(longitude: [30,32,38], latitude: [103,58,38])
        
        
        
        
        let view = MKMapView()
        self.content.addSubview(view)
        view.delegate = self
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let margin:CGFloat = 0
        view.topAnchor.constraint(equalTo: self.content.topAnchor, constant: margin).isActive = true
        view.leadingAnchor.constraint(equalTo: self.content.leadingAnchor, constant: margin).isActive = true
        view.trailingAnchor.constraint(equalTo: self.content.trailingAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: self.content.bottomAnchor, constant: 0).isActive = true
        
        let loc = CLLocationCoordinate2DMake(self.longitude, self.latitude)
        let span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
        let reg = MKCoordinateRegion(center: loc, span: span)
        view.region = reg
        view.showsScale = true
        view.showsCompass = true
//        let annloc = CLLocationCoordinate2DMake(self.longitude, self.latitude)
//        let ann = MKPointAnnotation()
//        ann.coordinate = annloc
//        ann.title = "你的位置"
//        //        ann.subtitle = "请再次点击吧！"
//        view.addAnnotation(ann)
        
       updateAnnotations(view: view, loc: loc)
        
        
        NotificationCenter.default.addObserver(forName: .MKAnnotationCalloutInfoDidChange, object: nil, queue: nil){ _ in
//            print("通知接到了")
            self.updateAnnotations(view: view, loc: loc)
            
        }
        
        //***********************************MapView***************************
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        nextBtn.addTarget(self, action: #selector(jumpToSecondViewController(_:)), for: .touchUpInside)
        
        callBackMemoryBtn.addTarget(self, action: #selector(jumpToVisitedViewController(_:)), for: .touchUpInside)
        
        //手指动作识别
        let upSwipeGesture = UISwipeGestureRecognizer()
        upSwipeGesture.direction = .up
        upSwipeGesture.addTarget(self, action: #selector(jumpToSecondViewController(_:)))
        
        self.view.addGestureRecognizer(upSwipeGesture)
        
        let leftSwipteGesture = UISwipeGestureRecognizer()
        leftSwipteGesture.direction = .left
        leftSwipteGesture.addTarget(self, action: #selector(jumpToVisitedViewController(_:)))
        
        self.view.addGestureRecognizer(leftSwipteGesture)
        
        //动画代码
        outAnimation(view: self.greetingLabel){
            self.outAnimation(view: self.questionLabel){
                self.outAnimation(view: self.memoryStackView)
            }
        }
        
    }
    
    func outAnimation(view:UIView,_ completion:(() -> Void)? = nil){
        let anim = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {
            view.alpha = 1
        }
        
        anim.startAnimation()
        anim.addCompletion { _ in
            if let completion = completion{
                completion()
            }
        }
    }
    
    @objc func jumpToSecondViewController(_ sender:Any){
        if let view = storyboard?.instantiateViewController(identifier: "secondViewController"){
            HelperFunc.push(viewController: view, navigationController: navigationController)
        }
    }
    
    @objc func jumpToVisitedViewController(_ sender:Any){
        if let view = storyboard?.instantiateViewController(identifier: "VisitedPlaceViewController"){
            
            navigationController?.pushViewController(view, animated: true)
        }
    }
    
    
    func getCoordinate(longitude :[Double],latitude:[Double]) -> (Double,Double){
        let h1 = longitude[0] + (longitude[1] + longitude[2]/60) / 60
        let h2 = latitude[0] + (latitude[1] + latitude[2]/60) / 60
        
        return (h1,h2)
    }
    
    func updateAnnotations(view:MKMapView,loc:CLLocationCoordinate2D){
        let areas = ItemList.sharedValue().userContentList
        for item in areas{
            self.searchFor(view: view, name: item.title, center: loc, types: [.nationalPark,.aquarium,.park,.amusementPark,.university,.library,.museum,.school,.zoo])
        }
    }
    
    func searchFor(view:MKMapView,name:String,center cloc:CLLocationCoordinate2D,types:[MKPointOfInterestCategory]){
            let req = MKLocalSearch.Request()
            req.naturalLanguageQuery = name
            req.region = MKCoordinateRegion(center: cloc, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
            req.resultTypes = .pointOfInterest
            let  filter = MKPointOfInterestFilter(including: types)
            req.pointOfInterestFilter = filter
            let search = MKLocalSearch(request: req)
            search.start { (responce, err) in
                guard let responce = responce else {print(err!); return}
                let mi = responce.mapItems[0]
                let place = mi.placemark
                let loc = place.location!.coordinate
//                let reg = MKCoordinateRegion(center: cloc, latitudinalMeters: 1200, longitudinalMeters: 1200)
//                view.setRegion(reg, animated: true)
                
                let a = MKPointAnnotation()
                a.title = mi.name
    //            a.subtitle = mi.phoneNumber
                a.coordinate = loc
                view.addAnnotation(a)
                
    //            view.zoom
            }
            
        }
    
    
    
}

