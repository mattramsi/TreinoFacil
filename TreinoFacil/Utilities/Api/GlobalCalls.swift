//
//  GlobalCalls.swift
//  TriggIos
//
//  Created by Matheus Ramos on 12/09/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Alamofire
import SwiftyJSON
import PromiseKit
import ObjectMapper


class GlobalCalls{
    
    
    static let shared = GlobalCalls()
    
    static let base_aquisicao = "https://jbz2e97r7h.execute-api.us-east-1.amazonaws.com/tst/cadastro"
    static let base_eventos   = "https://xpxn8yrtf8.execute-api.us-east-1.amazonaws.com/tst"
    
    static func defaultHeader() -> HTTPHeaders {
        var header = HTTPHeaders()
        header["Content-Type"] = "application/json"
        return header
    }
    
    static func basico(body: [String:Any])  -> Promise<JSON> {
        let url = base_aquisicao + "/basico/"
        let header = defaultHeader()
        return Service.sharedInstance.post(url: url, nomeMetodo: "basico", body: body, header: header)
    }
    
    static func login(body: [String:Any])  -> Promise<JSON> {
        let url = base_aquisicao + "/login/"
         let header = defaultHeader()
        return Service.sharedInstance.post(url: url, nomeMetodo: "basico", body: body, header: header)
    }
    
    static func esqueci(body: [String:Any])  -> Promise<JSON> {
        let url = base_aquisicao + "/esqueci/"
         let header = defaultHeader()
        return Service.sharedInstance.post(url: url, nomeMetodo: "basico", body: body, header: header)
    }
    
    static func celular(body: [String:Any])  -> Promise<JSON> {
        let url = base_aquisicao + "/celular/"
        var header = defaultHeader()
        header["clienteId"] = Utils.getStorage(name: "clienteId") as? String
        return Service.sharedInstance.post(url: url, nomeMetodo: "basico", body: body, header: header)
    }
    
    static func evento(body: [String:Any])  -> Promise<JSON> {
        let url = base_aquisicao + "/celular/"
        var header = defaultHeader()
        header["clienteId"] = Utils.getStorage(name: "clienteId") as? String
        return Service.sharedInstance.post(url: url, nomeMetodo: "evento", body: body, header: header)
    }
    
    static func agendamento(body: [String:Any])  -> Promise<JSON> {
        let url = base_eventos + "/agendamento/"
        var header = defaultHeader()
        header["clienteId"] = Utils.getStorage(name: "clienteId") as? String
        return Service.sharedInstance.post(url: url, nomeMetodo: "agendamento", body: body, header: header)
    }
    
    static func local(body: [String:Any])  -> Promise<JSON> {
        let url = base_eventos + "/local/"
        var header = defaultHeader()
        header["clienteId"] = Utils.getStorage(name: "clienteId") as? String
        return Service.sharedInstance.post(url: url, nomeMetodo: "local", body: body, header: header)
    }
    
    static func getAgendamento() -> Promise<JSON> {
        let url = base_eventos + "/agendamento/"
        var header = defaultHeader()
        header["clienteId"] = Utils.getStorage(name: "clienteId") as? String
        return Service.sharedInstance.get(url: url, nomeMetodo: "getAgendamento", header: header)
    }
    
    static func getEvento(lat: String, lng: String) -> Promise<JSON> {
        let url = base_eventos + "/evento?lat=" + lat + "&lng=" + lng
        let header = defaultHeader()
        return Service.sharedInstance.get(url: url, nomeMetodo: "getEvento", header: header)
    }
    
    static func getLocal() -> Promise<JSON> {
        let url = base_eventos + "/local/"
        let header = defaultHeader()
        return Service.sharedInstance.get(url: url, nomeMetodo: "getLocal", header: header)
    }

}
