//
//  CadastroCartaoCreditVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 09/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import CreditCardValidator

class CadastroCartaoCreditVC: BaseViewController {

    
    @IBOutlet weak var tf_number_card: UITextField!
    @IBOutlet weak var tf_validade: UITextField!
    @IBOutlet weak var tf_cvv: UITextField!
    @IBOutlet weak var tf_cpf: UITextField!
    @IBOutlet weak var tf_nome_titular: UITextField!
    @IBOutlet weak var btn_save: UIButton!
    @IBOutlet weak var lbl_type_card: UILabel!
    
    var form: Form!
    var cmp_cpf: TextFieldValidator!
    var cmp_nome: TextFieldValidator!
    var cmp_number_card: TextFieldValidator!
    var cmp_validade: TextFieldValidator!
    var cmp_cvv: TextFieldValidator!
    var tf_array: [UITextField]!
    var mask_validade = MaskValidade()
    var mask_cpf = MaskCPF()
    var mask_cvv = MaskCVV()
    var mask_number = MaskNumberCreditCard()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.loadLayout()
        self.validaFormFields()
    }
    
    func validaFormFields() {
        
        tf_array = [tf_number_card, tf_cvv, tf_validade, tf_nome_titular, tf_cpf]
        self.addInputAccessoryForTextFields(textFields: tf_array, dismissable: true, previousNextable: true)
        
        cmp_nome = TextFieldValidator(textField: self.tf_nome_titular!, validator: {
            return true
        })
        
        cmp_cpf = TextFieldValidator(textField: self.tf_cpf!, validator: {
            return Validators.isValidCPF(textfield: self.tf_cpf)
        })
        
        cmp_cvv = TextFieldValidator(textField: self.tf_cvv!, validator: {
            return Validators.matches(regex: "^[0-9]{3}$", string: self.tf_cvv.text!)
        })
        
        cmp_validade = TextFieldValidator(textField: self.tf_validade!, validator: {
            return Validators.matches(regex: "^[0-9]{4}$", string: self.tf_validade.text!.withoutSpecialCharacters)
        })
        
        cmp_number_card = TextFieldValidator(textField: self.tf_number_card!, validator: {
            let v = CreditCardValidator()
            let number = self.tf_number_card.text?.removingWhitespaces
            if let type = v.type(from: number!){
                print(type.name) // Visa, Mastercard, Amex etc.
                self.lbl_type_card.text = type.name
            } else {
                // I Can't detect type of credit card
                self.lbl_type_card.text = ""
            }
            return v.validate(string: number!)
        })
        
        let array : [Validatable] = [cmp_number_card, cmp_cvv, cmp_validade, cmp_nome, cmp_cpf]
        form = Form(button: btn_save, fields: array)
    }
    
    func loadLayout() {
        self.tf_cpf.delegate = mask_cpf
        self.tf_validade.delegate = mask_validade
        self.tf_cvv.delegate = mask_cvv
        self.tf_number_card.delegate = mask_number
    }
    
    func formatFormToSend() -> [String:Any] {
        let numero = self.tf_number_card.text?.withoutSpecialCharacters.removingWhitespaces
        let validade = self.tf_validade.text
        let cvv = self.tf_cvv.text
        let nome = self.tf_nome_titular.text
        var bandeira: String!
        
        let v = CreditCardValidator()
        if let number = self.tf_number_card.text?.removingWhitespaces {
            if let type = v.type(from: number){
                print(type.name) // Visa, Mastercard, Amex etc.
                bandeira = type.name
            } else {
                // I Can't detect type of credit card
            }
        }
        
        let dict = CartaoCredito(numero: numero!, validade: validade!, cvv: cvv!, nome: nome!, bandeira: bandeira).toJSON()
        return dict
    }
    

    @IBAction func saveCard(_ sender: Any) {
        let obj = formatFormToSend()
        
        
        GlobalCalls.saveCartao(networkRequestDelegate: self, body: obj, responseHandler: ResponseHandler(startHandler: {
            self.btn_save.loadingIndicator(true)
        }, finishHandler: {
            self.btn_save.loadingIndicator(false)
        }, successHandler: { (result) in
            
            self.dismiss(animated: true, completion: nil)
            
        }, failureHandler: { (error) in
            
        }))
       

    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
