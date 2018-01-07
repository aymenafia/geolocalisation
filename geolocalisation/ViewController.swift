//
//  ViewController.swift
//  geolocalisation
//
//  Created by Mohamed aymen AFIA on 07/01/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import GoogleMaps
class ViewController: UIViewController {

    var mapview : GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let camera = GMSCameraPosition.camera(withLatitude: 43, longitude: -77, zoom: 10 )
        
        mapview = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapview
        
    }

}

