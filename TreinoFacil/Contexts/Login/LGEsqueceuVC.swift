//
//  LGEsqueceuVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit

class LGEsqueceuVC: UIViewController {
    
    
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
        let cpf = self.tf_cpf.text?.withoutSpecialCharacters.removingWhitespaces
        let senha = self.tf_senha.text
        
        let obj = RegistroSenha(cpf: cpf!, senha: senha!, token: "")
        self.registroSenha = obj
        
        GlobalCalls.esqueci(body: obj.toJSON()).done { result -> Void in
            print(result)
            if result["id"].intValue == 102 {
                self.performSegue(withIdentifier: "toCodeSms", sender: nil)
            } else {
                Utils.openAlert(message: result["message"].stringValue)
            }
            
            }.catch { error in print(error) }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCodeSms" {
            let controller = segue.destination as! LGCodeEsqueceuVC
            controller.setObj(object: self.registroSenha)
        }
    }
}
