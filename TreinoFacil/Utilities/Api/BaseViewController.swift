//
//  BaseViewController.swift
//  TriggIos
//
//  Created by Cauê Jannini on 26/11/18.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

protocol NetworkRequestsDelegate {
    func addRequest(dataRequest: DataRequest)
    
    func removeRequest(dataRequest: DataRequest)
}

class BaseViewController : UIViewController, NetworkRequestsDelegate {
    
    var dataRequests: [DataRequest] = []
    
    func addRequest(dataRequest: DataRequest) {
        self.dataRequests.append(dataRequest)
    }
    
    func removeRequest(dataRequest: DataRequest) {
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        for dataRequest in dataRequests {
            dataRequest.cancel()
        }
    }
}

class BaseTableViewController : UITableViewController, NetworkRequestsDelegate {
    
    var dataRequests: [DataRequest] = []
    
    func addRequest(dataRequest: DataRequest) {
        self.dataRequests.append(dataRequest)
    }
    
    func removeRequest(dataRequest: DataRequest) {
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        for dataRequest in dataRequests {
            dataRequest.cancel()
        }
    }
}

class BaseTabBarViewController : UITabBarController, NetworkRequestsDelegate {
    
    var dataRequests: [DataRequest] = []
    
    func addRequest(dataRequest: DataRequest) {
        self.dataRequests.append(dataRequest)
    }
    
    func removeRequest(dataRequest: DataRequest) {
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        for dataRequest in dataRequests {
            dataRequest.cancel()
        }
    }
}
