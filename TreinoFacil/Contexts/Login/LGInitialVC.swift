//
//  LGInitialVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit

class LGInitialVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Utils.getClienteId.isEmpty {
            DispatchQueue.main.async(){
                self.performSegue(withIdentifier: "toLogin", sender: nil)
            }
            print("tem clienteID", Utils.getStorage(name: "clienteId"))
        } else {
            DispatchQueue.main.async(){
                self.performSegue(withIdentifier: "toHome", sender: nil)
            }
            
            print("Não tem clienteID", Utils.getStorage(name: "clienteId"))
        }
    }
    
}
