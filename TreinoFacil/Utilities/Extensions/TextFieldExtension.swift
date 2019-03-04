//
//  OutroTeste.swift
//  Formulario
//
//  Created by Matheus Ramos on 23/04/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    

    func underlined(){
    
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = Utils.hexStringToUIColor(hex: "#DDDDDD").cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.03702943
        
    }
    
    func validated(){
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.greenTrigg.cgColor
    }
    
    func invalid(){
         self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
      
    }
    
}
