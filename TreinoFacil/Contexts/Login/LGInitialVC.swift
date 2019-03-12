//
//  LGInitialVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit
import SwiftyJSON




class LGInitialVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        

        
        if Utils.getClienteId.isEmpty {
           DispatchQueue.main.async(){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let controller = storyboard.instantiateViewController(withIdentifier: "BemVindoVC") as? BemVindoVC {
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
            
            print("Não tem clienteID", Utils.getStorage(name: "clienteId"), Utils.getStorage(name: "isClient"))
        } else if !Utils.getClienteId.isEmpty {
            if Utils.isClient == "true" {
                 Utils.getAreaLogada(controller: self)
            } else if Utils.isClient == "false" {
                 Utils.getAreaLogadaCorporativo(controller: self)
            }
            
            print("tem clienteID", Utils.getStorage(name: "clienteId"), Utils.getStorage(name: "isClient"))
        } else {
            DispatchQueue.main.async(){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let controller = storyboard.instantiateViewController(withIdentifier: "BemVindoVC") as? BemVindoVC {
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
        }
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

class BemVindoVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    @IBAction func treinar(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "LGLoginVC") as? LGLoginVC {
             self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    @IBAction func corporativo(_ sender: Any) {
        print("oi")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "LGLoginCorporativoVC") as? LGLoginCorporativoVC {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

