//
//  Form.swift
//  Formulario
//
//  Created by Matheus Ramos on 25/04/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Foundation
import UIKit

class Form {
    
    var button: UIButton!
    var fields: [Validatable]
    
    init(button: UIButton, fields: [Validatable]) {
        self.button = button
        self.fields = fields
        self.button.isEnabled = false
        self.button.withBorderRadius()
        self.button.layer.backgroundColor = Colors.lightgray.cgColor
        
        for i in 0...(fields.count - 1) {
            fields[i].setForm(form: self)
        }
    }
    
    func teste() {
        for i in 0...(fields.count - 1) {
            if fields[i].isValid() {
                print("oi")
            }
         }
    }
    
    
    func checkButton() {
    
        let booleans = fields.map{$0.isValid()}
        if(booleans.contains(false)){
            button.isEnabled = false
            button.layer.backgroundColor = Colors.lightgray.cgColor
        } else{
            button.isEnabled = true
            button.layer.backgroundColor = Colors.pink.cgColor
        }
        
        for i in 0...(fields.count - 1) {
            print( "\(i)* campo: \(fields[i].isValid()) ")
        }
    }
    

}

