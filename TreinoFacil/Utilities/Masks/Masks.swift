//
//  CpfDelegate.swift
//  TriggIos
//
//  Created by Matheus Ramos on 24/05/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Foundation
import UIKit

class MaskCPF: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.count == 3 && string.count != 0 {
            textField.text = textField.text! + "."
        }
        else if textField.text?.count == 5 && string.count == 0 {
            textField.text = String(textField.text!.dropLast())
        }
        else if textField.text?.count == 7 && string.count != 0 {
            textField.text = textField.text! + "."
        }
        else if textField.text?.count == 10 && string.count == 0{
            textField.text = String(textField.text!.dropLast())
        }
        else if textField.text?.count == 11 && string.count != 0 {
            textField.text = textField.text! + "-"
        }
        else if textField.text?.count == 15 && string.count == 0 {
            textField.text = String(textField.text!.dropLast())
        }
        if textField.text?.count == 14 && string.count != 0 {
            return false
        }
        return true
    }
    
}

class MaskCelular: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField.text?.count == 2 && string.count != 0 {
            textField.text = "(" + textField.text! + ") "
        }
        else if textField.text?.count == 10 && string.count != 0 {
            textField.text = textField.text! + "-"
        }
        if textField.text?.count == 15 && string.count != 0 {
            return false
        }
        return true
    }
    
}

class MaskCep: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.count == 5 && string.count != 0 { textField.text = textField.text! + "-" }
        if textField.text?.count == 9 && string.count != 0 { return false }
        return true
    }
}

class MaskDate: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.count == 2 && string.count != 0 { textField.text = textField.text! + "/" }
        if textField.text?.count == 5 && string.count != 0 { textField.text = textField.text! + "/" }
        if textField.text?.count == 10 && string.count != 0 { return false }
        return true
    }
}

class MaskDinheiro: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let amountString = textField.text?.currencyInputFormatting() { textField.text = amountString }
        if textField.text?.count == 19 && string.count != 0 { return false }
        return true
    }
}
