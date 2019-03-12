//
//  MinhaAcademiaVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 10/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit

class MinhaAcademiaVC: UIViewController {

    @IBOutlet weak var btn_cadastrar_academia: UIButton!
    
    @IBOutlet weak var btn_cadastrar_aula: UIButton!
    

    @IBOutlet weak var sair: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logout(_ sender: Any) {
        Utils.resetDefaults()
        DispatchQueue.main.async(){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let controller = storyboard.instantiateViewController(withIdentifier: "BemVindoVC") as? BemVindoVC {
                self.present(controller, animated: true, completion: nil)
            }
        }
    
    }
}
