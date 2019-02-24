//
//  LGAssinatura.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit

class LGAssinatura: UIViewController {

    @IBOutlet weak var tf_celular: UITextField!
    @IBOutlet weak var switch_termos: UISwitch!
    @IBOutlet weak var btn_send: UIButton!
    var cmp_numero: TextFieldValidator!
    var cmp_termos: SwitchValidator!
    var form: Form!
    
    var mask_celular = MaskCelular()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.hideKeyboard()
        self.loadLayout()
        self.validaFormFields()
    }
    
    func validaFormFields() {
        
        cmp_numero = TextFieldValidator.init(textField: self.tf_celular!, validator: {
             let celularString = self.tf_celular.text?.withoutSpecialCharacters.removingWhitespaces
            return Validators.matches(regex: "^[0-9]{11}$", string: celularString!)
        })
        
        cmp_termos = SwitchValidator(_switch: self.switch_termos)
        
        let array : [Validatable] = [cmp_numero, cmp_termos]
        form = Form(button: btn_send, fields: array)
    }
    
    func loadLayout() {
        self.tf_celular.delegate = mask_celular
        self.switch_termos.isOn = false
    }
    
    var registroCelular: RegistroCelular!
    @IBAction func enviar(_ sender: Any) {
        let numero = self.tf_celular.text?.withoutSpecialCharacters.removingWhitespaces
        
        let obj = RegistroCelular(numero: numero!, token: "")
        self.registroCelular = obj
        
        GlobalCalls.celular(body: obj.toJSON()).done { result -> Void in
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
           let controller = segue.destination as! LGCodeVC
           controller.setObj(object: self.registroCelular)
        }
    }

}
