//
//  FormasDePagamentoTC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 09/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import ObjectMapper

struct AgendarApiModel: Mappable {
    
    var eventoId: String?
    var dataHorario: String?
    var cartaoId: String?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        eventoId <- map["eventoId"]
        dataHorario <- map["dataHorario"]
        cartaoId <- map["cartaoId"]
    }
    
    init(eventoId: String?, dataHorario: String?, cartaoId: String?) {
        self.eventoId = eventoId
        self.dataHorario = dataHorario
        self.cartaoId = cartaoId
    }
    
}

class FormasDePagamentoTC: BaseTableViewController {
    
    var cartoes: [CartaoCredito] = []
    var agendarApiModel: AgendarApiModel!
    
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
                

                return cell
            }
        } else if self.cartoes[index].numero == "9999" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AddCartaoCreditoCell", for: indexPath) as? AddCartaoCreditoCell {
                
                
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CartaoCreditoCell", for: indexPath) as? CartaoCreditoCell {
                
                cell.lbl_card_number.text = self.cartoes[index].numero
                cell.cartao = self.cartoes[index]
                
                return cell
            }
        }
      
        return UITableViewCell()
    }
    
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let card = self.cartoes[index]
        
        agendarApiModel.cartaoId = card.id
        
        let confirmAlert = UIAlertController(title: "", message: "Confirmar pagamento?", preferredStyle: UIAlertControllerStyle.alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            self.agendar()
        }))
        
        confirmAlert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: { (action: UIAlertAction!) in

        }))
        
        present(confirmAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func agendar() {
        
        let obj = agendarApiModel.toJSON()
        print(obj)
        
        GlobalCalls.agendamento(networkRequestDelegate: self, body: obj, responseHandler: ResponseHandler(startHandler: {
            
        }, finishHandler: {
            
        }, successHandler: { (result) in
            
          
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            if let controller = storyboard.instantiateViewController(withIdentifier: "LGSucessoEsqueceuVC") as? LGSucessoEsqueceuVC {
                self.present(controller, animated: true, completion: nil)
            }
            
        }, failureHandler: { (error) in
            
        }))
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


