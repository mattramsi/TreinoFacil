//
//  MinhasAcademiasTCTableViewController.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 10/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import ObjectMapper

class MinhasAcademiasCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    
}

class MinhasAcademiasTC: BaseTableViewController {

    var myGyms: [AcademiaCorporativa] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        GlobalCalls.getLocal(networkRequestDelegate: self, responseHandler: ResponseHandler(startHandler: {
            
        }, finishHandler: {
            
        }, successHandler: { (result) in
            
            self.myGyms = []

            for item in result["Items"].arrayValue {
                let academia: AcademiaCorporativa = Mapper<AcademiaCorporativa>().map(JSON: item.dictionaryObject!)!
                self.myGyms.append(academia)
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
        if self.myGyms.isEmpty {
            return 0
        }
        
        return myGyms.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MinhasAcademiasCell", for: indexPath) as! MinhasAcademiasCell
        
        let academia = self.myGyms[indexPath.row]
        cell.name.text = academia.nome
        cell.address.text = academia.enderecoCompleto
        cell.selectionStyle = .none
        return cell
    }
    
    
}
