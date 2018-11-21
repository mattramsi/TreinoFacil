//
//  TextFieldValidator.swift
//  Formulario
//
//  Created by Matheus Ramos on 25/04/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Foundation
import UIKit

class TextFieldValidator: Validatable {

    var textField: UITextField!
    var form: Form!
    var placeholder: String!
    var validador: () -> Bool
    var isTFValid: Bool = false
    
    init(textField: UITextField!, validator: @escaping () -> Bool) {
        self.textField = textField
        self.validador = validator
        self.textField.underlined()
        self.textField.addTarget(self, action: #selector(validacao), for:  UIControlEvents.allEditingEvents)
        self.textField.addTarget(self, action: #selector(displayMsg), for: UIControlEvents.allEditingEvents)
    }
    
    func setValueTextField(value: String) {
        self.textField.text = value
        self.putRemoveFocus()
    }

    func putRemoveFocus() {
        self.textField.becomeFirstResponder()
        self.textField.resignFirstResponder()
    }
    
    @objc func validacao(){
        
        self.isTFValid = self.validador()
        self.displayMsg()
        if form != nil { form.checkButton() }
    }
    
    func checkTF() {
        if !(self.textField.text?.isEmpty)! {
            if form != nil { form.checkButton() }
        }
    }
    
    @objc func displayMsg() {
        

            if !isTFValid && ((self.textField.text?.count)! > 0) {
                self.textField.invalid()
            } else if !isTFValid && ((self.textField.text?.count)! == 0) {
                self.textField.invalid()
            } else{
                self.textField.validated()
            }
        
    }
    
    func isValid() -> Bool { return isTFValid }
    func setForm(form: Form) { self.form = form }
}

class SwitchValidator: Validatable {
    
    var _switch: UISwitch!
    var form: Form!
    var label: UILabel!
    var placeholder: String!
    var msg: String!
    var isTFValid: Bool = false
    
    init(_switch: UISwitch!) {
        self._switch = _switch
        self.isTFValid = self._switch.isOn
        self._switch.addTarget(self, action: #selector(validacao), for: .valueChanged)
    }
    
    @objc func validacao(){
        self.isTFValid = self._switch.isOn
        if form != nil { form.checkButton() }
    }
    
    func isValid() -> Bool { return isTFValid }
    func setForm(form: Form) { self.form = form }
}



