//
//  LGCodeEsqueceuVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit

class LGCodeEsqueceuVC: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tf_1: UITextField!
    @IBOutlet weak var tf_2: UITextField!
    @IBOutlet weak var tf_3: UITextField!
    @IBOutlet weak var tf_4: UITextField!
    @IBOutlet weak var tf_5: UITextField!
    
    @IBOutlet weak var btn_send: UIButton!
    
    var registroSenha: RegistroSenha!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
        tf_1.tag = 0
        tf_2.tag = 1
        tf_3.tag = 2
        tf_4.tag = 3
        tf_5.tag = 5
        
        tf_1.becomeFirstResponder()
        tf_1.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        tf_2.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        tf_3.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        tf_4.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        tf_5.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
    }
    
    @objc func textFieldDidChange(textField: UITextField)
    {
        let text = textField.text
        if text?.utf16.count == 1 {
            switch textField {
            case tf_1:
                tf_2.becomeFirstResponder()
            case tf_2:
                tf_3.becomeFirstResponder()
            case tf_3:
                tf_4.becomeFirstResponder()
            case tf_4:
                tf_5.becomeFirstResponder()
            case tf_5:
                tf_5.resignFirstResponder()
            default:
                break
            }
        } else {
            switch textField {
            case tf_5:
                tf_4.becomeFirstResponder()
            case tf_4:
                tf_3.becomeFirstResponder()
            case tf_3:
                tf_2.becomeFirstResponder()
            case tf_2:
                tf_1.becomeFirstResponder()
            case tf_1:
                tf_1.resignFirstResponder()
            default:
                break
            }
        }
    }
    
    func setObj(object: RegistroSenha) {
        self.registroSenha = object
    }
    
    @IBAction func enviar(_ sender: Any) {
        
        var code = tf_1.text! + tf_2.text!
        let code2 = tf_3.text! + tf_4.text! + tf_5.text!
        code = code + code2
        
        if code.count < 5 {
            Utils.openAlert(message: "Código incompleto")
        } else {
            
            self.registroSenha.setToken(value: code)
            let obj = self.registroSenha.toJSON()
            print(obj)
            
            GlobalCalls.esqueci(networkRequestDelegate: self, body: obj, responseHandler: ResponseHandler(startHandler: {
                 self.btn_send.loadingIndicator(true)
            }, finishHandler: {
                 self.btn_send.loadingIndicator(false)
            }, successHandler: { (result) in
                print(result)
                
                if result["status"].stringValue == "200" {
                    self.performSegue(withIdentifier: "toSuccess", sender: nil)
                } else if result["id"].intValue == 103 {
                    Utils.openAlert(message: result["message"].stringValue)
                }
                
            }, failureHandler: { (error) in
            
            }))
        }
    }
}
