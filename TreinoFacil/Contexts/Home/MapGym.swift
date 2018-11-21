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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        // Do any additional setup after loading the view.
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
            annotation.title = academia.local?.nome as? String
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
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
        }
    }

}
