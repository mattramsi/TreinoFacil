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
    @IBOutlet weak var lbl_horario: UILabel!
    
    var academia: Academia!
    var horario: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.image.downloaded(from: (academia.local?.photoUrl)!)
        self.name.text = academia.local?.nome
        self.endereco.text = academia.local?.enderecoCompleto
        self.valor.text = Utils.formatCurrency(value: self.academia.configuracao?.valor?.quantidade)
        let dataHora = Utils.dateTimeline(string: self.horario)
        let data = dataHora[0]
        let hora = dataHora[1]
        self.lbl_horario.text = data + " às " + hora
    }

   
    func setAcademia(academia: Academia, horario: String) {
        self.academia = academia
        self.horario = horario
    }
    
}
