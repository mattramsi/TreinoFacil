//
//  LGEsqueceuVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit

class LGEsqueceuVC: BaseViewController {
    
    
    @IBOutlet weak var tf_cpf: UITextField!
    @IBOutlet weak var tf_senha: UITextField!
    @IBOutlet weak var btn_send: UIButton!
    
    
    var form: Form!
    var cmp_cpf: TextFieldValidator!
    var cmp_senha: TextFieldValidator!
    var tf_array: [UITextField]!
    var mask_cpf = MaskCPF()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        self.loadLayout()
        self.validaFormFields()
    }

    func validaFormFields() {
        
        cmp_cpf = TextFieldValidator.init(textField: self.tf_cpf!, validator: {
            return Validators.isValidCPF(textfield: self.tf_cpf!)
        })
        
        cmp_senha = TextFieldValidator(textField: self.tf_senha!, validator: {
            return Validators.matches(regex: "^[a-zA-Z0-9]{8,16}$", string: self.tf_senha.text!)
        })
        
        let array : [Validatable] = [cmp_cpf, cmp_senha]
        form = Form(button: btn_send, fields: array)
    }

    func loadLayout() {
        self.tf_cpf.delegate = mask_cpf

    }

    var registroSenha: RegistroSenha!
    @IBAction func enviar(_ sender: Any) {
       
      
        
        guard
            let cpf = self.tf_cpf.text?.withoutSpecialCharacters.removingWhitespaces,
            let senha = self.tf_senha.text
        else {
            return
        }
        
          print(senha)
        let obj = RegistroSenha(cpf: cpf, senha: senha, token: "")
        self.registroSenha = obj
        
        GlobalCalls.esqueci(networkRequestDelegate: self, body: obj.toJSON(), responseHandler: ResponseHandler(startHandler: {
            self.btn_send.loadingIndicator(true)
            }, finishHandler: {
                self.btn_send.loadingIndicator(false)
            }, successHandler: { (result) in
                
                if result["id"].intValue == 102 {
                    self.performSegue(withIdentifier: "toCodeSms", sender: nil)
                } else {
                    Utils.openAlert(message: result["message"].stringValue)
                }
                
            }, failureHandler: { (error) in
                
        }))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCodeSms" {
            let controller = segue.destination as! LGCodeEsqueceuVC
            controller.setObj(object: self.registroSenha)
        }
    }
}


class LGEsqueceuCorporativoVC: BaseViewController {
    
    
    @IBOutlet weak var tf_cnpj: UITextField!
    @IBOutlet weak var tf_senha: UITextField!
    @IBOutlet weak var btn_send: UIButton!
    
    
    var form: Form!
    var cmp_cnpj: TextFieldValidator!
    var cmp_senha: TextFieldValidator!
    var tf_array: [UITextField]!
    var mask_cnpj = MaskCNPJ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.loadLayout()
        self.validaFormFields()
    }
    
    func validaFormFields() {
        
        cmp_cnpj = TextFieldValidator.init(textField: self.tf_cnpj!, validator: {
            return Validators.isValidCPF(textfield: self.tf_cnpj!)
        })
        
        cmp_senha = TextFieldValidator(textField: self.tf_senha!, validator: {
            return Validators.matches(regex: "^[a-zA-Z0-9]{8,16}$", string: self.tf_senha.text!)
        })
        
        let array : [Validatable] = [cmp_cnpj, cmp_senha]
        form = Form(button: btn_send, fields: array)
    }
    
    func loadLayout() {
        self.tf_cnpj.delegate = mask_cnpj
        
    }
    
    var registroSenha: RegistroSenha!
    @IBAction func enviar(_ sender: Any) {
        
        
        
        guard
            let cnpj = self.tf_cnpj.text?.withoutSpecialCharacters.removingWhitespaces,
            let senha = self.tf_senha.text
            else {
                return
        }
        
        print(senha)
        let obj = RegistroSenha(cpf: cnpj, senha: senha, token: "")
        self.registroSenha = obj
        
        GlobalCalls.esqueci(networkRequestDelegate: self, body: obj.toJSON(), responseHandler: ResponseHandler(startHandler: {
            self.btn_send.loadingIndicator(true)
        }, finishHandler: {
            self.btn_send.loadingIndicator(false)
        }, successHandler: { (result) in
            
            if result["id"].intValue == 102 {
                self.performSegue(withIdentifier: "toCodeSms", sender: nil)
            } else {
                Utils.openAlert(message: result["message"].stringValue)
            }
            
        }, failureHandler: { (error) in
            
        }))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCodeSms" {
            let controller = segue.destination as! LGCodeEsqueceuVC
            controller.setObj(object: self.registroSenha)
        }
    }
}
