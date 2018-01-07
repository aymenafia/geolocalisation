//
//  ViewController.swift
//  geolocalisation
//
//  Created by Mohamed aymen AFIA on 07/01/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import GoogleMaps
class ViewController: UIViewController,CLLocationManagerDelegate {

    var mapview : GMSMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        
        if CLLocationManager.locationServicesEnabled(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
        let camera = GMSCameraPosition.camera(withLatitude: 43, longitude: -77, zoom: 10 )
        mapview = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapview
        
    }

    var oldLocation = CLLocationCoordinate2DMake(0, 0)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        oldLocation = (manager.location?.coordinate)!
        
        let markerMe = GMSMarker()
        markerMe.position = CLLocationCoordinate2DMake(oldLocation.latitude, oldLocation.longitude)
        markerMe.title = "Me"
        markerMe.snippet = "here is my location"
        markerMe.icon = UIImage(named:"mario5")
        markerMe.map = mapview
        
        
        let camera = GMSCameraPosition.camera(withLatitude: oldLocation.latitude, longitude: oldLocation.longitude, zoom: 30 )
        self.mapview.camera = camera
        
    }
}

