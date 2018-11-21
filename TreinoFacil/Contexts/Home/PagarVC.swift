//
//  PagarVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 21/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit

class PagarVC: UIViewController {

    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var endereco: UILabel!
    @IBOutlet weak var valor: UILabel!
    
    var academia: Academia!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.image.downloaded(from: (academia.local?.photoUrl)!)
        self.name.text = academia.local?.nome
        self.endereco.text = academia.local?.enderecoCompleto
    }

   
    func setAcademia(academia: Academia) {
        self.academia = academia
    }
    
}
