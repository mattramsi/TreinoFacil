//
//  MapGym.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit
import MapKit

class MapGymVC: BaseViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var academias = [Academia]()
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboard()
        self.mapView.delegate = self

        self.setMark()
        
        if self.locationManager != nil {
            if let userLocation = self.locationManager.location?.coordinate {
                
                let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation, 1000, 1000)
                mapView.setRegion(viewRegion, animated: false)
            }
            
            DispatchQueue.main.async {
                self.locationManager.startUpdatingLocation()
            }
        }
    }
  
    func setListGym(array: [Academia]){
       self.removeMarks()
       self.academias = array
       self.setMark()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation! is MKUserLocation {
            return
        }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        let annotation = view.annotation
        
        let myCustomView: GymAnnotation = UINib(nibName: "GymAnnotationView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! GymAnnotation
        
        myCustomView.frame = CGRect(x: 10, y: self.view.frame.height/2, width: self.view.frame.width - 20, height: 180)
        
        if annotationView == nil {
            annotationView = MKPinAcademiaAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            
            if let content =  annotationView?.annotation as? AcademiaPointAnnotation {
                let urlString = content.academia.local?.photoUrl!
                myCustomView.img_gym.downloaded(from: urlString!, contentMode: UIViewContentMode.scaleAspectFit)
                myCustomView.lbl_address.text = content.academia.local?.enderecoCompleto
                myCustomView.lbl_name.text = content.academia.local?.nome
                myCustomView.lbl_aula.text = content.academia.nome
                
                myCustomView.agendar = {
                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    if let controller = storyboard.instantiateViewController(withIdentifier: "HorariosTC") as? HorariosTC {
                        controller.academia = content.academia
                        self.present(controller, animated: true, completion: nil)
                    }
                }
            }
            
        } else {
            annotationView!.annotation = annotation
        }
        
        
        self.view.addSubview(myCustomView)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        for childView: AnyObject in self.view.subviews {
            if let gymAnnotation = childView as? GymAnnotation {
                gymAnnotation.removeFromSuperview();
            }
        }
    }

    func setMark() {
        for academia in academias {
            let pin = AcademiaPointAnnotation()
            pin.academia = academia
            pin.title = academia.local?.nome
            pin.coordinate = CLLocationCoordinate2D(latitude: academia.local?.lat as! Double, longitude: academia.local?.lng as! Double)
            mapView.addAnnotation(pin)
        }

     
    }
    
    func removeMarks() {
        let allAnnottations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnottations)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }


}

class AcademiaPointAnnotation: MKPointAnnotation {
    
    var academia: Academia!
    
}

class MKPinAcademiaAnnotationView: MKPinAnnotationView {
    
    var academia: Academia!
    
}
