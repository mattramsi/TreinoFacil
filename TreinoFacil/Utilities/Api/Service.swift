//
//  Service.swift
//  TriggIos
//
//  Created by Matheus Ramos on 27/08/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Alamofire
import SwiftyJSON
import ObjectMapper

struct Service {
    
    private static let manager: SessionManager = Alamofire.SessionManager.default
    
    // REQUEST PADRÃO ALAMOFIRE
    static func request(networkRequestDelegate: NetworkRequestsDelegate?, header: HTTPHeaders, url: String, nomeMetodo: String, method: HTTPMethod, queryParams: [String : String]?, body: [String: Any]?, responseHandler: ResponseHandler ) -> DataRequest {
        
        responseHandler.startHandler()
        
        var urlWithParams = url
        if queryParams != nil {
            urlWithParams += "?"
            for (e, value) in queryParams! {
                urlWithParams += e+"="+value+"&"
            }
            if urlWithParams.last == "&" {
                urlWithParams.removeLast()
            }
        }

       let dataRequest: DataRequest = self.manager.request(urlWithParams, method: method, parameters: body, encoding: JSONEncoding.default, headers: header)
        
        networkRequestDelegate?.addRequest(dataRequest: dataRequest)
        
        dataRequest.responseJSON { dataResponse in
            responseHandler.onCompleted(dataResponse: dataResponse)
            networkRequestDelegate?.removeRequest(dataRequest: dataRequest)
        }
        
        return dataRequest
    }
    
    static func get(networkRequestDelegate: NetworkRequestsDelegate?, header: HTTPHeaders, url: String, nomeMetodo: String, queryParams: [String : String]?, responseHandler: ResponseHandler ) -> DataRequest {
        return self.request(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: nomeMetodo, method: .get, queryParams: queryParams, body: nil, responseHandler: responseHandler)
    }
    
    static func post(networkRequestDelegate: NetworkRequestsDelegate?, header: HTTPHeaders, url: String, nomeMetodo: String, queryParams: [String : String]?, body: [String: Any]?, responseHandler: ResponseHandler ) -> DataRequest {
       
        return self.request(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: nomeMetodo, method: .post, queryParams: queryParams, body: body, responseHandler: responseHandler)
    }
    
    static func put(networkRequestDelegate: NetworkRequestsDelegate?, header: HTTPHeaders, url: String, nomeMetodo: String, queryParams: [String : String]?, body: [String: Any]?, responseHandler: ResponseHandler ) -> DataRequest {
        
        return self.request(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: nomeMetodo, method: .put, queryParams: queryParams, body: body, responseHandler: responseHandler)
    }
    
    static func delete(networkRequestDelegate: NetworkRequestsDelegate?, header: HTTPHeaders, url: String, nomeMetodo: String, queryParams: [String : String]?, body: [String: Any]?, responseHandler: ResponseHandler ) -> DataRequest {
        
        return self.request(networkRequestDelegate: networkRequestDelegate, header: header, url: url, nomeMetodo: nomeMetodo, method: .delete, queryParams: queryParams, body: body, responseHandler: responseHandler)
    }
    

}
