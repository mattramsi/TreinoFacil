//
//  listGymsTableViewController.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit

class ListGymsCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var aula: UILabel!
  
}

class ListGymsVC: BaseTableViewController {

    
    var academias = [Academia]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
  

    func setListGym(array: [Academia]){
        self.academias = array
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return academias.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListGym", for: indexPath) as! ListGymsCell

        cell.name.text = self.academias[indexPath.row].local?.nome
        cell.aula.text = self.academias[indexPath.row].nome
        
        return cell
    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let academiaSelecionada = academias[indexPath.row]
        
        print("ola", academiaSelecionada.toJSON())
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "HorariosTC") as? HorariosTC {
            controller.academia = academiaSelecionada
            self.present(controller, animated: true, completion: nil)
        }
    }
    

}
