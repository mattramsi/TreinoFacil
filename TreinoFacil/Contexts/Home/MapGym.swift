//
//  MapGym.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit

class MapGymVC: UIViewController {
    
    var academias = [Academia]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setListGym(array: [Academia]){
        self.academias = array
    }

}
