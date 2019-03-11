//
//  ValidarAgendamentoVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 11/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit

class ValidarAgendamentoVC: BaseViewController {

    @IBOutlet weak var tf_codigo: UITextField!
    
    @IBOutlet weak var btn_validar: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func validar(_ sender: Any) {
        
        guard let codigo = self.tf_codigo.text else {
            Utils.openAlert(message: "Por favor, digite o código de agendamento!")
            return
        }
        
        GlobalCalls.validaAgendamento(networkRequestDelegate: self, agendamentoId: codigo, responseHandler: ResponseHandler(startHandler: {
             self.btn_validar.loadingIndicator(true, color: .black)
        }, finishHandler: {
             self.btn_validar.loadingIndicator(true, color: .black)
        }, successHandler: { (result) in
            
            if result["id"].intValue == 10 {
                Utils.openAlert(message: result["message"].stringValue)
            } else {
                
               self.navigationController?.popViewController(animated: true)
                Utils.openAlert(message: "Agendamento confirmado!")
            }
            
            
        }, failureHandler: { (error) in
             Utils.openAlert(message: "Erro ao validar código!")
        }))
    }
    
}
