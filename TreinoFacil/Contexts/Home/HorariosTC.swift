//
//  HorariosTC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 03/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit


class HorariosCell: UITableViewCell {
    
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var hora: UILabel!
    
}

class HorariosTC: BaseTableViewController {
    
    var academia: Academia!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return academia.proximasDatas!.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HorariosCell", for: indexPath) as! HorariosCell
        
        let horario = self.academia.proximasDatas![indexPath.row]
        let dataHora = Utils.dateTimeline(string: horario)
        cell.data.text = dataHora[0]
        cell.hora.text = dataHora[1]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let horarioSelecionado = self.academia.proximasDatas![indexPath.row]
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "PagarVC") as? PagarVC {
            controller.setAcademia(academia: self.academia, horario: horarioSelecionado)
             DispatchQueue.main.async(execute: {
                self.present(controller, animated: true, completion: nil)
             })
        }
    }
    
   
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
