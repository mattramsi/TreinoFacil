//
//  OutrosVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit

class OutrosCell: UITableViewCell {
   
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_arrow: UIImageView!
}

class OutrosTC: BaseTableViewController {

    var options = ["Dúvidas Frequentes", "Fale com a gente", "Formas de Pagamento", "Mudar Senha", "Trocar Celular", "Sobre o Treino Fácil", "Avalie o App", "Sair"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.options.isEmpty {
            return 0
        }
        
        return options.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OutrosCell", for: indexPath) as! OutrosCell
        
        cell.lbl_name.text = self.options[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     
            let menu_clicked = self.options[indexPath.row]
            self.menuAction(title: menu_clicked)
        
        
    }
    
    func menuAction(title: String) {
        
        
        print(title)
        switch title {
        case "Dúvidas Frequentes":
            break
        case "Fale com a gente":
            break
        case "Formas de Pagamento":
            
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            if let controller = storyboard.instantiateViewController(withIdentifier: "MeusCartoesTC") as? MeusCartoesTC {
                self.present(controller, animated: true, completion: nil)
            }
            
            break
        case "Mudar Senha":
            break
        case "Alterar Email":
            break
        case "Sobre o Treino Fácil":
            break
        case "Trocar Celular":
            break
        case "Avalie o App":
            
            guard let url = URL(string: "https://itunes.apple.com/app/") else { return }
            UIApplication.shared.open(url)
            
            break
        case "Sair":
            
            Utils.resetDefaults()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let controller = storyboard.instantiateViewController(withIdentifier: "LGInitialVC") as? LGInitialVC {
                self.present(controller, animated: true, completion: nil)
            }
            break
        default:
            break
        }
    }
    
    
}
