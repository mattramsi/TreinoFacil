//
//  CadastroAcademiaVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 10/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import ObjectMapper

struct LocalToApi: Mappable {
    
    var lat: Float?
    var lng: Float?
    var nome: String?
    var enderecoCompleto: String?
    var photoUrl: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        lat <- map["lat"]
        lng <- map["lng"]
        enderecoCompleto <- map["enderecoCompleto"]
        nome <- map["nome"]
        photoUrl <- map["photoUrl"]
        
    }
}



class CadastroAcademiaVC: BaseViewController, FormBase {

    @IBOutlet weak var tf_endereco: UITextField!
    @IBOutlet weak var tf_estado: UITextField!
    @IBOutlet weak var tf_numero: UITextField!
    @IBOutlet weak var tf_cidade: UITextField!
    @IBOutlet weak var tf_nome_academia: UITextField!
    @IBOutlet weak var btn_send: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    func validaFormFields() {
        
    }
    
    func loadLayout() {
        
    }
    
    func formatFormToSend() -> [String : Any] {
        
        return [:]
    }
    
    @IBAction func registrar(_ sender: Any) {
        let obj = formatFormToSend()
        GlobalCalls.local(networkRequestDelegate: self, body: obj, responseHandler: ResponseHandler(startHandler: {
            
        }, finishHandler: {
            
        }, successHandler: { (result) in
            
        }, failureHandler: { (error) in
            
        }))
        
    }


}
