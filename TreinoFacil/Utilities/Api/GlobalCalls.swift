//
//  GlobalCalls.swift
//  TriggIos
//
//  Created by Matheus Ramos on 12/09/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Alamofire
import SwiftyJSON
import ObjectMapper

class GlobalCalls{
    
    static let base_aquisicao = "https://jbz2e97r7h.execute-api.us-east-1.amazonaws.com/tst/cadastro"
    static let base_eventos   = "https://xpxn8yrtf8.execute-api.us-east-1.amazonaws.com/tst"
    
    static func setHeader(with clienteId: Bool) -> HTTPHeaders {
        var header = HTTPHeaders()
        header["Content-Type"] = "application/json"
        if clienteId {
            header["clienteId"] = Utils.getStorage(name: "clienteId") as? String
        }
        return header
    }
    
    static func basico(networkRequestDelegate: NetworkRequestsDelegate, body: [String:Any], responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_aquisicao + "/basico/"
        let header = setHeader(with: false)
        
        return Service.post(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "basico", queryParams: nil, body: body, responseHandler: responseHandler)
    }
    
    static func login(networkRequestDelegate: NetworkRequestsDelegate, body: [String:Any], responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_aquisicao +  "/login/"
        let header = setHeader(with: false)
        
        return Service.post(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "login", queryParams: nil, body: body, responseHandler: responseHandler)
    }
    
    static func esqueci(networkRequestDelegate: NetworkRequestsDelegate, body: [String:Any], responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_aquisicao +  "/esqueci/"
        let header = setHeader(with: false)
        
        return Service.post(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "esqueci", queryParams: nil, body: body, responseHandler: responseHandler)
    }
    
    static func celular(networkRequestDelegate: NetworkRequestsDelegate, body: [String:Any], responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_aquisicao +  "/celular/"
        let header = setHeader(with: true)
        
        return Service.post(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "celular", queryParams: nil, body: body, responseHandler: responseHandler)
    }
    
    static func evento(networkRequestDelegate: NetworkRequestsDelegate, body: [String:Any], responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_eventos +  "/evento/"
        let header = setHeader(with: true)
        
        return Service.post(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "evento", queryParams: nil, body: body, responseHandler: responseHandler)
    }
    
    static func agendamento(networkRequestDelegate: NetworkRequestsDelegate, body: [String:Any], responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_eventos +  "/agendamento/"
        let header = setHeader(with: true)
        
        return Service.post(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "agendamento", queryParams: nil, body: body, responseHandler: responseHandler)
    }
    
    static func local(networkRequestDelegate: NetworkRequestsDelegate, body: [String:Any], responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_eventos +  "/local/"
        let header = setHeader(with: true)
        
        return Service.post(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "local", queryParams: nil, body: body, responseHandler: responseHandler)
    }
    
    static func saveCartao(networkRequestDelegate: NetworkRequestsDelegate, body: [String:Any], responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_eventos +  "/cartao/"
        let header = setHeader(with: true)
        
        return Service.post(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "saveCartao", queryParams: nil, body: body, responseHandler: responseHandler)
    }
    
    static func sendPerguntas(networkRequestDelegate: NetworkRequestsDelegate, body: [String:Any], responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_aquisicao +  "/perguntas"
        let header = setHeader(with: true)
        
        return Service.post(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "sendPerguntas", queryParams: nil, body: body, responseHandler: responseHandler)
    }
    
    static func validaAgendamento(networkRequestDelegate: NetworkRequestsDelegate, agendamentoId: String, responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_eventos +  "/agendamento/" + agendamentoId
        let header = setHeader(with: true)
        
        return Service.post(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "sendPerguntas", queryParams: nil, body: nil, responseHandler: responseHandler)
    }
    
    static func getCards(networkRequestDelegate: NetworkRequestsDelegate, responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_eventos +  "/cartao/"
        let header = setHeader(with: true)
        
        return Service.get(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "getCards", queryParams: nil, responseHandler: responseHandler)
    }
    
    static func deleteCard(networkRequestDelegate: NetworkRequestsDelegate, cartaoId: String, responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_eventos +  "/cartao/" + cartaoId
        let header = setHeader(with: true)
        
        return Service.delete(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "getCards", queryParams: nil, body: nil, responseHandler: responseHandler)
    }
    
    static func getAgendamento(networkRequestDelegate: NetworkRequestsDelegate, responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_eventos +  "/agendamento/"
        let header = setHeader(with: true)
        
        return Service.get(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "getAgendamento", queryParams: nil, responseHandler: responseHandler)
    }
    
    static func getEvento(networkRequestDelegate: NetworkRequestsDelegate, lat: String, lng: String, responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_eventos +  "/evento?lat=23.5680812&lng=-46.5522709"
        let header = setHeader(with: false)
        
        return Service.get(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "getEvento", queryParams: nil, responseHandler: responseHandler)
    }
    
    static func getLocal(networkRequestDelegate: NetworkRequestsDelegate, responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_eventos + "/local/"
        let header = setHeader(with: true)
        
        return Service.get(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "getLocal", queryParams: nil, responseHandler: responseHandler)
    }
    
    static func getAreaLogada(networkRequestDelegate: NetworkRequestsDelegate, responseHandler: ResponseHandler)  -> DataRequest {
        let url = base_aquisicao + "/area-logada"
        let header = setHeader(with: true)
        
        return Service.get(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: "getAreaLogada", queryParams: nil, responseHandler: responseHandler)
    }
    
}


//GlobalCalls.getDadosCartao(networkRequestDelegate: self, responseHandler: ResponseHandler(
//    startHandler: {
//        
//}, finishHandler: {
//    
//}, successHandler: { (result) in
//    
//
//}, failureHandler: { (error) in
//    print(error)
//  
//}))
