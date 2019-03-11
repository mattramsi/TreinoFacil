//
//  LGSucessoVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit

class LGSucessoVC: BaseViewController {

    @IBOutlet weak var btn_sair: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if Utils.isClient == "true" {
           self.btn_sair.setTitle("Treinar", for: .normal)
        } else{
            self.btn_sair.setTitle("Continuar", for: .normal)
        }
    }
    
    @IBAction func goToHome(_ sender: Any) {
        
        print(Utils.isClient)
        if Utils.isClient == "true" {
            Utils.getAreaLogada(controller: self)
        } else{
            Utils.getAreaLogadaCorporativo(controller: self)
        }
        
    }
    

}

class LGSucessoEsqueceuVC: BaseViewController {
    
    @IBOutlet weak var btn_sair: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    @IBAction func gotoLogin(_ sender: Any) {
        
        if Utils.isClient == "true" {
            Utils.getAreaLogada(controller: self)
        } else{
            Utils.getAreaLogadaCorporativo(controller: self)
        }
        
    }
}
