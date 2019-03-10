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
        Utils.getAreaLogada(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if Utils.getClienteId.isEmpty {
           DispatchQueue.main.async(){
                self.performSegue(withIdentifier: "toBemVindo", sender: nil)
            }
            
            print("Não tem clienteID", Utils.getStorage(name: "clienteId"))
        } else {
            print("tem clienteID", Utils.getStorage(name: "clienteId"))
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

