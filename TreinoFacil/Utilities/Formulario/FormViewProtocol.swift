//
//  FormViewProtocol.swift
//  TriggIos
//
//  Created by Matheus Ramos on 11/09/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Foundation

protocol FormBase {
    
    func validaFormFields()
    func loadLayout()
    func formatFormToSend() -> [String:Any]
    
}

