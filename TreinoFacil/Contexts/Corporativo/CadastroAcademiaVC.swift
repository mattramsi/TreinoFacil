//
//  CadastroAcademiaVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 10/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import ObjectMapper
import CoreLocation

struct LocalToApi: Mappable {
    
    var lat: Float?
    var lng: Float?
    var nome: String?
    var enderecoCompleto: String?
    var photoUrl: String?
    
    init?(map: Map) {}
    
    init(lat: Float, lng: Float, nome: String, endereco: String, photoUrl: String?) {
        self.lat = lat
        self.nome = nome
        self.lng = lng
        self.enderecoCompleto = endereco
        self.photoUrl = photoUrl
    }
    
    mutating func mapping(map: Map) {
        
        lat <- map["lat"]
        lng <- map["lng"]
        enderecoCompleto <- map["enderecoCompleto"]
        nome <- map["nome"]
        photoUrl <- map["photoUrl"]
        
    }
}



class CadastroAcademiaVC: BaseViewController {

    @IBOutlet weak var tf_endereco: UITextField!
    @IBOutlet weak var tf_estado: UITextField!
    @IBOutlet weak var tf_numero: UITextField!
    @IBOutlet weak var tf_cidade: UITextField!
    @IBOutlet weak var tf_nome_academia: UITextField!
    @IBOutlet weak var btn_send: UIButton!
    @IBOutlet weak var tf_foto_url: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
  
    func checkIfCanSend() {
        if
            (self.tf_endereco.text?.isEmpty)! ||
            (self.tf_estado.text?.isEmpty)! ||
            (self.tf_numero.text?.isEmpty)! ||
            (self.tf_cidade.text?.isEmpty)! ||
            (self.tf_nome_academia.text?.isEmpty)! ||
            (self.tf_foto_url.text?.isEmpty)!
        {
             Utils.openAlert(message: "Dados não completos ou inválidos!")
        } else {
            
            self.send()
            
        }
        
        
    }
    
    func send() {
        
        let address = self.tf_endereco.text! + ", " + self.tf_numero.text! + ", " + self.tf_estado!.text!
        
        let geoCoder = CLGeocoder()
        var local: LocalToApi!
        
        if !address.isEmpty {
            
            geoCoder.geocodeAddressString(address) { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                    else {
                        // handle no location found
                        return
                }
                
                
                let lat =  location.coordinate.latitude
                let lng = location.coordinate.longitude
                let endereco = address
                let nomeAcademia = self.tf_nome_academia.text
                let photoUrl = self.tf_foto_url.text
                
                local = LocalToApi(lat: Float(lat), lng: Float(lng), nome: nomeAcademia!, endereco: endereco, photoUrl: photoUrl)
                
                GlobalCalls.local(networkRequestDelegate: self, body: local.toJSON(), responseHandler: ResponseHandler(startHandler: {
                    self.btn_send.loadingIndicator(true, color: .black)
                }, finishHandler: {
                    self.btn_send.loadingIndicator(false, color: .black)
                }, successHandler: { (result) in
                    
                    self.navigationController?.popViewController(animated: true)
                    
                    DispatchQueue.main.async(execute: {
                        Utils.openAlert(message: "Academia cadastrada coms sucesso!")
                    })
                    
                }, failureHandler: { (error) in
                    Utils.openAlert(message: "Não foi possível cadastrar essa academia! Tente mais tarde!")
                }))
            }
        }
    }
    
    @IBAction func registrar(_ sender: Any) {
      
        self.checkIfCanSend()
    }
}
