//
//  LGRegistroCorporativoVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 10/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//
import UIKit

class LGRegistroCorporativoVC: BaseViewController, FormBase {
    
    @IBOutlet weak var tf_cnpj: UITextField!
    @IBOutlet weak var tf_nome: UITextField!
    @IBOutlet weak var tf_email: UITextField!
    @IBOutlet weak var tf_senha: UITextField!
    
    @IBOutlet weak var btn_registrar: UIButton!
    
    var form: Form!
    var cmp_cnpj: TextFieldValidator!
    var cmp_nome: TextFieldValidator!
    var cmp_email: TextFieldValidator!
    var cmp_senha: TextFieldValidator!
    var tf_array: [UITextField]!
    var mask_data = MaskDate()
    var mask_cpf = MaskCPF()
    var mask_cnpj = MaskCNPJ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        self.loadLayout()
        self.validaFormFields()
    }
    
    func validaFormFields() {
        
        tf_array = [tf_nome, tf_cnpj, tf_email, tf_senha]
        self.addInputAccessoryForTextFields(textFields: tf_array, dismissable: true, previousNextable: true)
        
        cmp_nome = TextFieldValidator(textField: self.tf_nome!, validator: {
            return Validators.matches(regex: "([^\\s]+)\\s([^\\s]+)(.*)", string: self.tf_nome.text!)
        })
        
        cmp_cnpj = TextFieldValidator(textField: self.tf_cnpj!, validator: {
            return (self.tf_cnpj.text?.isValidCNPJ)!
        })
        
        cmp_email = TextFieldValidator(textField: self.tf_email!, validator: {
            return Validators.matches(regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", string: self.tf_email.text!)
        })
        
  
        
        cmp_senha = TextFieldValidator(textField: self.tf_senha!, validator: {
            return Validators.matches(regex: "^[a-zA-Z0-9]{8,16}$", string: self.tf_senha.text!)
        })
        
        let array : [Validatable] = [cmp_nome, cmp_cnpj, cmp_email, cmp_senha]
        form = Form(button: btn_registrar, fields: array)
    }
    
    func loadLayout() {
        self.tf_cnpj.delegate = mask_cnpj
    }
    
    func formatFormToSend() -> [String:Any] {
        let cnpj = self.tf_cnpj.text?.withoutSpecialCharacters.removingWhitespaces
        let nome = self.tf_nome.text
        let email = self.tf_email.text
        let senha = self.tf_senha.text
        
       
        
        let dict = Registro(cpf: cnpj!, nome: nome!, email: email!, dtNascimento: nil, senha: senha!).toJSON()
        
        print(dict)
        return dict
    }
    
    
    @IBAction func registrar(_ sender: Any) {
        let obj = formatFormToSend()
        
        GlobalCalls.basico(networkRequestDelegate: self, body: obj, responseHandler: ResponseHandler(startHandler: {
            self.btn_registrar.loadingIndicator(true)
        }, finishHandler: {
            self.btn_registrar.loadingIndicator(false)
        }, successHandler: { (result) in
            
            if result["status"].stringValue == "200" {
                self.performSegue(withIdentifier: "toAvaliation", sender: nil)
                Utils.openAlert(message: "Registro com sucesso!")
                Utils.setStorage(name: "clienteId", value: result["result"].stringValue)
                
            } else if result["id"].intValue ==  100 {
                Utils.openAlert(message: result["message"].stringValue)
            }
            
        }, failureHandler: { (error) in
            
        }))
        
        
    }
    
   
}


