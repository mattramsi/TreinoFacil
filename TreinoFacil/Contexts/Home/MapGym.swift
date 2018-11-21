//
//  MapGym.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit
import MapKit

class MapGymVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var academias = [Academia]()
    @IBOutlet weak var mapView: MKMapView!
    
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        _locationManager.distanceFilter = 10.0  // Movement threshold for new events
        //  _locationManager.allowsBackgroundLocationUpdates = true // allow in background
        
        return _locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        self.mapView.delegate = self
        // Do any additional setup after loading the view.
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        self.setMark()
    }
    
    func setListGym(array: [Academia]){
       self.removeMarks()
       self.academias = array
       self.setMark()
    }
    
    func setMark() {
        
        for academia in academias {
            let annotation = MKPointAnnotation()
            annotation.title = academia.local?.nome
            annotation.coordinate = CLLocationCoordinate2D(latitude: academia.local?.lat as! Double, longitude: academia.local?.lng as! Double)
            mapView.addAnnotation(annotation)
        }
    }
    
    func removeMarks() {
        let allAnnottations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnottations)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            print("lat: ", location.coordinate.latitude)
            print("lon: ", location.coordinate.longitude)
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let camera = MKMapCamera(lookingAtCenter: center, fromEyeCoordinate: center, eyeAltitude: 10000.0)
            self.mapView.setCamera(camera, animated: false)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }


}
