//
//  PopUpDetailViewController.swift
//  MYSquare
//
//  Created by akif demirezen on 24/02/2018.
//  Copyright © 2018 demirezenOrganization. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage

class PopUpDetailViewController: BaseController{
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var labelOfRating: CustomLabel!
    @IBOutlet weak var mageViewOFStar: UIImageView!
    
    
    @IBOutlet weak var imageViewOfSquare: UIImageView!
    @IBOutlet weak var mapKitView: MKMapView!
   
    public static var lat : Double = 0.0
    public static var lng : Double = 0.0
    public static var imageUrl : String = ""
    public static var imageStar = UIImage()
    public static var rating : Double = 0.0
    
    var tap: UITapGestureRecognizer?
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.blurEffectView =  UIVisualEffectView(effect: self.blurEffect)
        self.blurEffectView?.frame = view.bounds
        self.blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.view.addSubview(blurEffectView!)
        self.mapKitView.delegate = self
        let image = URL(string: PopUpDetailViewController.imageUrl)
        self.imageViewOfSquare.sd_setImage(with: image)
       
        tap = UITapGestureRecognizer(target: self, action:#selector(self.turnBack))
        tap?.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap!)
        
        self.mageViewOFStar.image = PopUpDetailViewController.imageStar
        self.labelOfRating.text = String(PopUpDetailViewController.rating)
        
        
        
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        determineLocation()
    }
    @objc func turnBack(){
        self.dismiss(animated: true, completion: nil)
    }
    func determineLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension PopUpDetailViewController : CLLocationManagerDelegate,MKMapViewDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: PopUpDetailViewController.lat, longitude: PopUpDetailViewController.lng)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapKitView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(PopUpDetailViewController.lat, PopUpDetailViewController.lng);
        myAnnotation.title = "Square's Location"
        mapKitView.addAnnotation(myAnnotation)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
}


