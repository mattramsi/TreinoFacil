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

class LGLoginVC: UIViewController, FormBase {
   
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
        
        GlobalCalls.login(body: obj).done { result -> Void in
            print(result)
            if result["status"].stringValue == "200" {
                
                self.performSegue(withIdentifier: "toHome", sender: nil)
                Utils.setStorage(name: "clienteId", value: result["result"].stringValue)
                print("TOKEN: ", Utils.getStorage(name: "clienteId"))
                
            } else if result["id"].intValue ==  99 {
                Utils.openAlert(message: result["message"].stringValue)
            }
            
        }.catch { error in print(error) }

    }
    
}
