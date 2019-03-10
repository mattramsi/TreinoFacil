//
//  ResponseHandler.swift
//  TriggIos
//
//  Created by Cauê Jannini on 23/11/18.
//  Copyright © 2018 Curso IOS. All rights reserved.
//
import Alamofire
import SwiftyJSON
import ObjectMapper

class ResponseHandler {
    
    var startHandler : (() -> Void) = {
        print("startedHandler not overriden")
    }
    
    var successHandler : ((JSON) -> Void) = { result in
        print("successHandler not overriden")
    }
    
    var failureHandler : ((JSON) -> Void) = { result in
        print("failureHandler not overriden")
    }
    
    var finishHandler : (() -> Void) = {
        print("completeHandler not overriden")
    }
    
    var apiErrorHandler : ((JSON) -> Void) = { result in
        print("apiErrorHandler not overriden")
    }
    
    var httpErrorHandler : ((Error) -> Void) = { result in
        print("httpErrorHandler not overriden")
    }
    
    init(successHandler: @escaping (Any) -> Void) {
        self.successHandler = successHandler
    }
    
    init(startHandler: @escaping () -> Void, finishHandler: @escaping () -> Void, successHandler: @escaping (JSON) -> Void) {
        self.startHandler = startHandler
        self.finishHandler = finishHandler
        self.successHandler = successHandler
    }
    
    init(startHandler: @escaping () -> Void, finishHandler: @escaping () -> Void, successHandler: @escaping (JSON) -> Void, failureHandler: @escaping (JSON) -> Void) {
        self.startHandler = startHandler
        self.finishHandler = finishHandler
        self.successHandler = successHandler
        self.failureHandler = failureHandler
    }

    
    func onCompleted(dataResponse: DataResponse<Any>) {
        
        finishHandler()
        
        print("RESPONSE: \(dataResponse)")
        
        switch(dataResponse.result) {
            case .success(let responseObject):
                
                let response = JSON(responseObject)
                onSuccess(result: response)
                break
            case .failure(let error):
               
                let response = JSON(error)
                onApiError(apiError: response)
                break
        }
    }
    
    func dataResponseFailure(error: Error) {
        onHttpError(error: error)
    }
   
    func onSuccess(result: JSON) {
        self.successHandler(result)
    }
    
    func onApiError (apiError: JSON) {
        self.failureHandler(apiError)
        self.apiErrorHandler(apiError)
    }
    
    func onHttpError (error: Error){
        if let apiError = error as? JSON {
            self.failureHandler(apiError)
        }
        self.httpErrorHandler(error)
    }
}
