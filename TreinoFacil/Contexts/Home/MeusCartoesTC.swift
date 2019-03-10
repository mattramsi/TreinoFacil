//
//  MeusCartoesTC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 09/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import ObjectMapper

class MeusCartoesTC: BaseTableViewController {
    
    var cartoes: [CartaoCredito] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib(nibName: "CartaoCreditoCell", bundle: nil), forCellReuseIdentifier: "CartaoCreditoCell")
        tableView.register(UINib(nibName: "AddCartaoCreditoCell", bundle: nil), forCellReuseIdentifier: "AddCartaoCreditoCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the sample data structure.
        if self.cartoes.isEmpty {
            return 1
        }
        
        return cartoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        if self.cartoes.isEmpty {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AddCartaoCreditoCell", for: indexPath) as? AddCartaoCreditoCell {
                 cell.selectionStyle = .none
                
                return cell
            }
        } else if self.cartoes[index].numero == "9999" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AddCartaoCreditoCell", for: indexPath) as? AddCartaoCreditoCell {
                 cell.selectionStyle = .none
                
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CartaoCreditoCell", for: indexPath) as? CartaoCreditoCell {
                
                cell.lbl_card_number.text = self.cartoes[index].numero
                cell.cartao = self.cartoes[index]
                cell.selectionStyle = .none
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func getCartoes() {
        
        self.cartoes = []
        
        GlobalCalls.getCards(networkRequestDelegate: self, responseHandler: ResponseHandler(startHandler: {
            
        }, finishHandler: {
            
        }, successHandler: { (result) in
            
            for item in result["Items"].arrayValue {
                let cartao: CartaoCredito = Mapper<CartaoCredito>().map(JSON: item.dictionaryObject!)!
                self.cartoes.append(cartao)
            }
            
            self.addlastCard()
            self.tableView.reloadData()
            print("entrou", self.cartoes)
            
        }, failureHandler: { (error) in
            
        }))
        
    }
    
    func addlastCard() {
        let card = CartaoCredito(numero: "9999", validade: "", cvv: "", nome: "", bandeira: "")
        self.cartoes.append(card)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getCartoes()
    }
    
    
}



