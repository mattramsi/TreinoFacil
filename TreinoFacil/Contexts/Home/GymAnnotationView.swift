//
//  GymAnnotationView.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 03/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//
import UIKit


class GymAnnotation: UIView {
    
    @IBOutlet weak var lbl_aula: UILabel!
    @IBOutlet weak var img_gym: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var btn_agendar: UIButton!
    var agendar: (() -> Void)!
   
    @IBAction func agendar(_ sender: Any) {
        if self.agendar != nil {
             self.agendar()
        }
    }
}
