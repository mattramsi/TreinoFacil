//
//  CartaoCredito.swift
//  
//
//  Created by Matheus Ramos on 09/03/19.
//

import UIKit
import ObjectMapper


struct CartaoCredito : Mappable {
    var numero : String?
    var validade : String?
    var cvv : String?
    var nome : String?
    var cpf : String?
    var bandeira : String?
    var dtCriacao : String?
    var id : String?
    var owner : String?
    
    init?(map: Map) {
        
    }
    
    init(numero: String, validade: String, cvv: String, nome: String, bandeira: String) {
        self.numero  = numero
        self.validade = validade
        self.cvv = cvv
        self.nome = nome
        self.bandeira = bandeira
    }
    
    mutating func mapping(map: Map) {
        
        numero <- map["numero"]
        validade <- map["validade"]
        cvv <- map["cvv"]
        nome <- map["nome"]
        cpf <- map["cpf"]
        bandeira <- map["bandeira"]
        dtCriacao <- map["dtCriacao"]
        id <- map["id"]
        owner <- map["owner"]
      
    }
    
}


struct AcademiaCorporativa : Mappable {
    
    var dtCriacao : String?
    var lng : Float?
    var enderecoCompleto : String?
    var owner : String?
    var nome : String?
    var lat : Float?
    var id : String?
    var photoUrl : String?
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        dtCriacao <- map["dtCriacao"]
        lng <- map["lng"]
        enderecoCompleto <- map["enderecoCompleto"]
        owner <- map["owner"]
        nome <- map["nome"]
        lat <- map["lat"]
        id <- map["id"]
        photoUrl <- map["photoUrl"]

    }
    
}
