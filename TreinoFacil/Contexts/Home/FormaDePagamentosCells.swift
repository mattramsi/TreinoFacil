//
//  FormaDePagamentosCells.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 09/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit

class CartaoCreditoCell: UITableViewCell {
    
    @IBOutlet weak var lbl_card_number: UILabel!
    var cartao: CartaoCredito!
    
    @IBAction func editar(_ sender: Any) {
        
        if !(cartao.id?.isEmpty)! {
            if let controller = self.viewController() as? BaseTableViewController {
                GlobalCalls.deleteCard(networkRequestDelegate: controller, cartaoId: cartao.id!, responseHandler: ResponseHandler(startHandler: {
                    
                }, finishHandler: {
                   
                }, successHandler: { (result) in
                    
                    controller.tableView.reloadData()
                    
                }, failureHandler: { (error) in
                    
                }))
            }
        }
    }
}


class AddCartaoCreditoCell: UITableViewCell {
    
    
    @IBAction func addCreditCard(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "CadastroCartaoCreditVC") as? CadastroCartaoCreditVC {
            self.viewController()?.present(controller, animated: true, completion: nil)
        }
        
    }
}
