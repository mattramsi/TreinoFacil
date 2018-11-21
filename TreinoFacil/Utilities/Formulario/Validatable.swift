//
//  Validatable.swift
//  Formulario
//
//  Created by Matheus Ramos on 25/04/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Foundation

protocol Validatable {
    
    func isValid() -> Bool
    func setForm(form: Form)
    
}
