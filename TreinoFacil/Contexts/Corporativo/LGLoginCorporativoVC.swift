//
//  LGLoginCorporativoVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 10/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit

class LGLoginCorporativoVC: BaseViewController, FormBase {

    @IBOutlet weak var tf_cnpj: UITextField!
    @IBOutlet weak var tf_senha: UITextField!
    @IBOutlet weak var btn_logar: UIButton!
    
    var form: Form!
    var cmp_Cnpf: TextFieldValidator!
    var cmp_senha: TextFieldValidator!
    var mask_cnpj = MaskCNPJ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.hideKeyboard()
        self.loadLayout()
        self.validaFormFields()
    }
    
    func validaFormFields() {
        cmp_Cnpf = TextFieldValidator.init(textField: self.tf_cnpj!, validator: {
            return (self.tf_cnpj.text?.isValidCNPJ)!
        })
        
        cmp_senha = TextFieldValidator(textField: self.tf_senha!, validator: {
            return Validators.matches(regex: "^[a-zA-Z0-9]{8,16}$", string: self.tf_senha.text!)
        })
        
        let array : [Validatable] = [cmp_Cnpf, cmp_senha]
        form = Form(button: btn_logar, fields: array)
    }
    
    func loadLayout() {
        self.tf_cnpj.delegate = mask_cnpj
    }
    
    func formatFormToSend() -> [String:Any] {
        let cnpf = self.tf_cnpj.text?.withoutSpecialCharacters.removingWhitespaces
        let senha = self.tf_senha.text
        
        let loginDict = Login(cpf: cnpf!, senha: senha!).toJSON()
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
                print("TOKEN: ", Utils.getStorage(name: "clienteId"))
                
                if Utils.getClienteId.isEmpty {
                    DispatchQueue.main.async(){
                        self.performSegue(withIdentifier: "toLogin", sender: nil)
                    }
                } else {
                    Utils.getAreaLogada(controller: self)
                }
                
            } else if result["id"].intValue ==  99 {
                
                Utils.openAlert(message: result["message"].stringValue)
            }
            
        }, failureHandler: { (error) in
            print(error)
            
        }))
        
        
    }
    


}
