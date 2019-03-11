//
//  MeusTreinosVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit
import ObjectMapper

class MeusTreinosCell: UITableViewCell {
//    ListAgendamento
    @IBOutlet weak var data: UILabel!
    
   
}


class MeusTreinosVC: BaseTableViewController {
    
    var agendamentos: [Agendamento] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
   
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        GlobalCalls.getAgendamento(networkRequestDelegate: self, responseHandler: ResponseHandler(startHandler: {
            
        }, finishHandler: {
            
        }, successHandler: { (result) in
            
            self.agendamentos = []
            print(result)
            for item in result["Items"].arrayValue {
                let agendamento: Agendamento = Mapper<Agendamento>().map(JSON: item.dictionaryObject!)!
                self.agendamentos.append(agendamento)
            }
            
            self.tableView.reloadData()
            
        }, failureHandler: { (error) in
            
        }))
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.agendamentos.isEmpty {
            return 0
        }
        
        return agendamentos.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListAgendamento", for: indexPath) as! MeusTreinosCell
        
        let dataHora = Utils.dateTimeline(string:  self.agendamentos[indexPath.row].dataHorario!)
        let data = dataHora[0]
        let hora = dataHora[1]
        cell.data.text = data + " às " + hora

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        let agendamento = self.agendamentos[index]
        Utils.showTextAlert(viewController: self, title: "CÓDIGO DE AGENDAMENTO", description: agendamento.id!)
        
    }
    
    
    

}
