//
//  LGLoginVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class LGLoginVC: BaseViewController, FormBase {
   
    @IBOutlet weak var tf_cpf: UITextField!
    @IBOutlet weak var tf_senha: UITextField!
    @IBOutlet weak var btn_logar: UIButton!
    
    var form: Form!
    var cmp_Cpf: TextFieldValidator!
    var cmp_senha: TextFieldValidator!
    var mask_cpf = MaskCPF()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.hideKeyboard()
       self.loadLayout()
       self.validaFormFields()
    }
    
    func validaFormFields() {
        cmp_Cpf = TextFieldValidator.init(textField: self.tf_cpf!, validator: {
            return Validators.isValidCPF(textfield: self.tf_cpf!)
        })
        
        cmp_senha = TextFieldValidator(textField: self.tf_senha!, validator: {
            return Validators.matches(regex: "^[a-zA-Z0-9]{8,16}$", string: self.tf_senha.text!)
        })
        
        let array : [Validatable] = [cmp_Cpf, cmp_senha]
        form = Form(button: btn_logar, fields: array)
    }
    
    func loadLayout() {
        self.tf_cpf.delegate = mask_cpf
    }
    
    func formatFormToSend() -> [String:Any] {
        let cpf = self.tf_cpf.text?.withoutSpecialCharacters.removingWhitespaces
        let senha = self.tf_senha.text
        
        let loginDict = Login(cpf: cpf!, senha: senha!).toJSON()
        return loginDict
    }


    @IBAction func logar(_ sender: Any) {
        let obj = formatFormToSend()
        
    
        GlobalCalls.login(networkRequestDelegate: self, body: obj, responseHandler: ResponseHandler(
            startHandler: {
            self.btn_logar.loadingIndicator(true)
        }, finishHandler: {
            self.btn_logar.loadingIndicator(false)
        }, successHandler: { (result) in
            
           
            if result["status"].stringValue == "200" {
                
               
                Utils.setStorage(name: "clienteId", value: result["result"].stringValue)
                Utils.setStorage(name: "isClient", value: "true")
                print("TOKEN: ", Utils.getStorage(name: "clienteId"))
                
                if Utils.getClienteId.isEmpty {
                    DispatchQueue.main.async(){
                        self.performSegue(withIdentifier: "toLogin", sender: nil)
                    }
                } else {
                    self.getAreaLogada()
                }
                
            } else if result["id"].intValue ==  99 {
                
                Utils.openAlert(message: result["message"].stringValue)
            }
        
        }, failureHandler: { (error) in
            print(error)
        
        }))


    }
    
    func getAreaLogada() {
        
        GlobalCalls.getAreaLogada(networkRequestDelegate: self, responseHandler: ResponseHandler(startHandler: {
            
        }, finishHandler: {
            
        }, successHandler: { (result) in
            
            let id = result["id"].intValue
            print(id)
            switch id {
                
            case 1:
                //celular
                DispatchQueue.main.async(){
                    self.performSegue(withIdentifier: "toAssinatura", sender: nil)
                }
                break
            case 2:
                //perguntas
                DispatchQueue.main.async(){
                    self.performSegue(withIdentifier: "toHome", sender: nil)
                }
                break
            case 101:
                DispatchQueue.main.async(){
                    self.performSegue(withIdentifier: "toHome", sender: nil)
                }
                break
            default:
                break
            }
            
            
        }, failureHandler: { (error) in
            
        }))
    }
    
    override func viewWillAppear(_ animated: Bool) {
         Utils.setStorage(name: "isClient", value: "true")
    }
}
