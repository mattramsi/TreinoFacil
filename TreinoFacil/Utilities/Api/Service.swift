//
//  Service.swift
//  TriggIos
//
//  Created by Matheus Ramos on 27/08/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Alamofire
import SwiftyJSON
import PromiseKit

struct Service {
    
    static let sharedInstance = Service()
    private var manager: SessionManager
    
    private init() {
        self.manager = Alamofire.SessionManager.default
    }

    
    func get(url: String, nomeMetodo: String, header: HTTPHeaders) -> Promise<JSON> {
        
        print(url)
        return Promise() { resolver in
            
            self.manager.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                switch(response.result) {
                    case .success(let responseObject):
                        
                        resolver.fulfill(JSON(responseObject))
                    
                    case .failure(let error): print(error); resolver.reject(error)
                }
            }
        }
    }
    
    func post(url: String, nomeMetodo: String, body: [String : Any]?, header: HTTPHeaders) -> Promise<JSON> {
        
        print(url)
        return Promise() { resolver in
            
            self.manager.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                switch(response.result) {
                    case .success(let responseObject):
                        
                        resolver.fulfill(JSON(responseObject))
                    
                    case .failure(let error): print(error); resolver.reject(error)
                }
            }
        }
    }
    
}
