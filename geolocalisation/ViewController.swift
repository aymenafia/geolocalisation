//
//  ViewController.swift
//  geolocalisation
//
//  Created by Mohamed aymen AFIA on 07/01/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import GoogleMaps

struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}


class ViewController: UIViewController,CLLocationManagerDelegate , GMSMapViewDelegate{
    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70
    
     var chosenPlace: MyPlace?
    let previewDemoData = [(title: "The Polar Junction", img: #imageLiteral(resourceName: "mario5"), price: 10), (title: "The Nifty Lounge", img: #imageLiteral(resourceName: "mario3"), price: 8), (title: "The Lunar Petal", img: #imageLiteral(resourceName: "mario2"), price: 12)]
    
    
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
        self.mapview.camera = camera
        self.mapview.delegate = self
       // initGoogleMaps()
        
        
        setupViews()
    }

    
   
    var oldLocation = CLLocationCoordinate2DMake(0, 0)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        oldLocation = (manager.location?.coordinate)!
        
        let markerMe = GMSMarker()
        markerMe.position = CLLocationCoordinate2DMake(oldLocation.latitude, oldLocation.longitude)
        
        
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: UIImage(named:"mario5")!, borderColor: UIColor.white, tag: 1)
        
            //markerMe.iconView = customMarker
        
        
        
//        markerMe.title = "Me"
//        markerMe.snippet = "here is my location"
//        //markerMe.icon = UIImage(named:"mario5")
//        markerMe.map = mapview
        
        
        let camera = GMSCameraPosition.camera(withLatitude: oldLocation.latitude, longitude: oldLocation.longitude, zoom: 15 )
        self.mapview.camera = camera
        
        showPartyMarkers(lat: oldLocation.latitude, long: oldLocation.longitude)

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting location \(error)")
    }
    
    
    
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("test")
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return false }
        let img = customMarkerView.img!
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.black, tag: customMarkerView.tag)
        
        marker.iconView = customMarker
        
        return false
    }

    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        
        restaurantPreviewView=RestaurantPreviewView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 190))
        
        
        
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return nil }
        let data = previewDemoData[customMarkerView.tag]
        restaurantPreviewView.setData(title: data.title, img: data.img, price: data.price)
        
        let infoView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        infoView.backgroundColor = UIColor.black
       
        
        print(data.title)
        return  restaurantPreviewView
    }
    
    
    
    func showPartyMarkers(lat: Double, long: Double) {
        mapview.clear()
        for i in 0..<3 {
            let randNum=Double(arc4random_uniform(30))/10000
            let marker=GMSMarker()
            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: previewDemoData[i].img, borderColor: UIColor.darkGray, tag: i)
            marker.iconView=customMarker
            let randInt = arc4random_uniform(4)
            if randInt == 0 {
                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long-randNum)
            } else if randInt == 1 {
                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long+randNum)
            } else if randInt == 2 {
                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long-randNum)
            } else {
                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long+randNum)
            }
            marker.map = mapview
        }
    }
    
    var restaurantPreviewView: RestaurantPreviewView = {
        let v=RestaurantPreviewView()
        return v
    }()
    
    
    
    
    @objc func restaurantTapped(tag: Int) {
        let v=DetailsVC()
        v.passedData = previewDemoData[tag]
        print("xxxxxxxxxxx")
        self.present(v, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let tag = customMarkerView.tag
        restaurantTapped(tag: tag)
    }
    func setupViews() {
        
        
        
      
    }
}

