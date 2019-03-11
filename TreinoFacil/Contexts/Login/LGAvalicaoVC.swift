//
//  LGAvalicaoVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 20/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit
import ObjectMapper

struct Perguntas: Mappable {
    
    var pergunta1: Bool?
    var pergunta2: Bool?
    var pergunta3: Bool?
    var pergunta4: Bool?
    var pergunta5: Bool?
    
    init(p1: Bool, p2: Bool, p3: Bool, p4: Bool, p5: Bool) {
        self.pergunta1 = p1
        self.pergunta2 = p2
        self.pergunta3 = p3
        self.pergunta4 = p4
        self.pergunta5 = p5
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        pergunta1 <- map["pergunta1"]
        pergunta2 <- map["pergunta2"]
        pergunta3 <- map["pergunta3"]
        pergunta4 <- map["pergunta4"]
        pergunta5 <- map["pergunta5"]
        
    }
    
}

class LGAvalicaoVC: BaseViewController {
    
    @IBOutlet weak var btn_enviar: UIButton!
    @IBOutlet weak var perg_1: UISwitch!
    @IBOutlet weak var perg_2: UISwitch!
    @IBOutlet weak var perg_3: UISwitch!
    @IBOutlet weak var perg_4: UISwitch!
    @IBOutlet weak var perg_5: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func send(_ sender: Any) {
        
        let obj = Perguntas(p1: perg_1.isOn, p2: perg_2.isOn, p3: perg_3.isOn, p4: perg_4.isOn, p5: perg_5.isOn).toJSON()
        
        GlobalCalls.sendPerguntas(networkRequestDelegate: self, body: obj, responseHandler: ResponseHandler(startHandler: {
            
        }, finishHandler: {
            
        }, successHandler: { (result) in
            DispatchQueue.main.async(){
                self.performSegue(withIdentifier: "toAssinatura", sender: nil)
            }
        }, failureHandler: { (error) in
            
        }))
        
    }
    

}
