//
//  PesquisaVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON
import ObjectMapper

class PesquisaVC: BaseViewController, UISearchBarDelegate {
    
    var x: Bool = false
    @IBOutlet weak var changeViewBtn: UIButton!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive : Bool = false
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
   
    var academias = [Academia]()
   
    var filtered:[Academia] = []
    
    private lazy var mapVC: MapGymVC = {
        let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "MapVC" ) as! MapGymVC
        viewController.locationManager = self.locManager
        return viewController
    }()
    
    private lazy var listVC: ListGymsVC = {
        let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "ListVC" ) as! ListGymsVC
        return viewController
    }()
 
    @IBAction func changeView(_ sender: Any) {
        
        
        if !x  {
            x = true
            
            changeViewBtn.setImage(#imageLiteral(resourceName: "maps-and-flags"), for: .normal)
            changeViewBtn.setTitle("Mapa", for: .normal)
        } else{
            x = false
            changeViewBtn.setImage(#imageLiteral(resourceName: "listas"), for: .normal)
            changeViewBtn.setTitle("Listas", for: .normal)
        }
        
        update(first: x)
    }
    
    func update(first: Bool) {
        
        if !first {
            add(asChildViewController: mapVC)
        } else {
            add(asChildViewController: listVC)
        }
        
        self.getCurrentLocation()
        
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        
        viewController.view.frame = self.content.bounds;
        viewController.willMove(toParentViewController: self)
        self.content.addSubview(viewController.view)
        self.addChildViewController(viewController)
        viewController.didMove(toParentViewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeViewBtn.layer.borderWidth = 1
        searchBar.delegate = self
        add(asChildViewController: mapVC)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.locManager.startUpdatingLocation()
        self.getCurrentLocation()
    }
    
    func getCurrentLocation() {
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if (authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse ||
            authorizationStatus == CLAuthorizationStatus.authorizedAlways){
            
            locManager.startUpdatingHeading()

            guard let currentLocation = locManager.location else {
                return
            }

            print("LATITUDE: ", currentLocation.coordinate.latitude)
            print("longitude: ", currentLocation.coordinate.longitude)
            let lat = String(currentLocation.coordinate.latitude)
            let lng = String(currentLocation.coordinate.longitude)
  
            GlobalCalls.getEvento(networkRequestDelegate: self, lat: lat, lng: lng, responseHandler: ResponseHandler(startHandler: {
                
                }, finishHandler: {
                    
                }, successHandler: { (result) in
                    
                    for item in result["Items"].arrayValue {
                        let academia: Academia = Mapper<Academia>().map(JSON: item.dictionaryObject!)!
                        self.academias.append(academia)
                    }
                    
                    
                    self.mapVC.setListGym(array: self.academias)
                    self.listVC.setListGym(array: self.academias)
                        
                }, failureHandler: { (error) in
                    
            }))
            
        } else {
            locManager.requestWhenInUseAuthorization()
            self.getCurrentLocation()
        }

    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        self.hideKeyboard()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.hideKeyboard()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.hideKeyboard()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = self.academias.filter({ $0.nome?.lowercased().range(of: searchText.lowercased(), options: .caseInsensitive) != nil || $0.local?.nome!.lowercased().range(of: searchText.lowercased(), options: .caseInsensitive) != nil || ($0.tags?.contains(searchText.lowercased()))!})
        
        print(filtered.count)
        self.mapVC.setListGym(array: filtered)
        self.listVC.setListGym(array: filtered)
        
        if(filtered.count == 0){
            searchActive = false;
            self.mapVC.setListGym(array: academias)
            self.listVC.setListGym(array: academias)
        } else {
            searchActive = true;
        }
    }
    
    
}
