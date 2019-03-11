//
//  CadastroAulaVC.swift
//  TreinoFacil
//
//  Created by Matheus Ramos on 10/03/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import ObjectMapper


struct DiasDaSemana {
    
    var id: Int?
    var nome: String?
    
    init(id: Int, nome: String) {
        self.id = id
        self.nome = nome
    }
}

class CheckableTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_title: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
}


class DefaultTC: UITableViewController {
    
    var viewThatOpened: UIViewController!
    var arrayToSelect: [Any] = []
    var arrayReturn: [Any] = []
    
    override func viewDidLoad() {
        self.tableView.allowsMultipleSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        
     
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.arrayToSelect.isEmpty {
            return 0
        }
        
        return arrayToSelect.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckableCell", for: indexPath) as! CheckableTableViewCell
        
        
        if let array = self.arrayToSelect[indexPath.row] as? AcademiaCorporativa {
            self.tableView.allowsMultipleSelection = false
            cell.lbl_title.text = array.nome
        }
        
        if let array = self.arrayToSelect[indexPath.row] as? DiasDaSemana {
            self.tableView.allowsMultipleSelection = true
            cell.lbl_title.text = array.nome
        }
        
        if let array = self.arrayToSelect[indexPath.row] as? String {
            self.tableView.allowsMultipleSelection = true
            cell.lbl_title.text = array
        }
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell = tableView.cellForRow(at: indexPath)
        
        if let controller = viewThatOpened as? CadastroAulaVC {
            
            if let academia = self.arrayToSelect[indexPath.row] as? AcademiaCorporativa {
                controller.setAcademia(academia: academia)

            }
            
            if let diaDaSemana = self.arrayToSelect[indexPath.row] as? DiasDaSemana {
                
                if cell!.isSelected == true {
                    self.arrayReturn.append(diaDaSemana)
                }
            
                controller.setDiasDaSemana(array: self.arrayReturn as! [DiasDaSemana])
            }
            
            if let horarios = self.arrayToSelect[indexPath.row] as? String {
               
                if cell!.isSelected == true {
                    self.arrayReturn.append(horarios)
                }
                
                controller.setHorarios(array: self.arrayReturn as! [String])
            }
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        if let controller = viewThatOpened as? CadastroAulaVC {
            
            if let diaDaSemana = self.arrayToSelect[indexPath.row] as? DiasDaSemana {
                
                var array = self.arrayReturn as! [DiasDaSemana]
                
                if !cell!.isSelected {
                    if let index = array.index(where: {$0.id == diaDaSemana.id}) {
                        array.remove(at: index)
                    }
                    
                    self.arrayReturn = array
                }
                
                controller.setDiasDaSemana(array: self.arrayReturn as! [DiasDaSemana])
            }
            
            
            if let horario = self.arrayToSelect[indexPath.row] as? String {
                
                var array = self.arrayReturn as! [String]
                
                if !cell!.isSelected {
                    if let index = array.index(where: {$0 == horario}) {
                        array.remove(at: index)
                    }
                    
                    self.arrayReturn = array
                }
                
                controller.setHorarios(array: self.arrayReturn as! [String])
            }
            
            
        }
    }
    
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}


class CadastroAulaVC: BaseViewController, FormBase {
    
    @IBOutlet weak var tf_nome_academia: UITextField!
    @IBOutlet weak var tf_nome_aula: UITextField!
    @IBOutlet weak var tf_descricao: UITextField!
    @IBOutlet weak var tf_dias_semana: UITextField!
    @IBOutlet weak var tf_horarios: UITextField!
    @IBOutlet weak var tf_duracao: UITextField!
    @IBOutlet weak var tf_valor: UITextField!
    var myGyms: [AcademiaCorporativa] = []
    var academiaSelecionada: AcademiaCorporativa!
    var diasDaSemanaSelecionados: [Int]! = []
    var horariosSelecionados: [String]! = []
    var mask_money = MaskDinheiro()
    
    @IBOutlet weak var tf_tags: UITextField!
    @IBOutlet weak var btn_send: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()

        // Do any additional setup after loading the view.
        tf_nome_academia.addTarget(self, action: #selector(openSelectMyGyms), for: UIControlEvents.touchDown)
        tf_dias_semana.addTarget(self, action: #selector(openSelectDiasSemana), for: UIControlEvents.touchDown)
        tf_horarios.addTarget(self, action: #selector(openSelectHorarios), for: UIControlEvents.touchDown)
        
        self.tf_valor.delegate = mask_money
        
        
        self.getAcademias()
    }
    
    func getAcademias() {
        
        GlobalCalls.getLocal(networkRequestDelegate: self, responseHandler: ResponseHandler(startHandler: {
            
        }, finishHandler: {
            
        }, successHandler: { (result) in
            
            self.myGyms = []
            
            for item in result["Items"].arrayValue {
                let academia: AcademiaCorporativa = Mapper<AcademiaCorporativa>().map(JSON: item.dictionaryObject!)!
                self.myGyms.append(academia)
            }
            
        }, failureHandler: { (error) in
            
        }))
    }
    
    @objc func openSelectMyGyms(textField: UITextField) {
        
       self.openSelect(array: self.myGyms)
    }
    
    @objc func openSelectDiasSemana(textField: UITextField) {
       
        let diasDaSemana = [
            DiasDaSemana(id: 1, nome: "Segunda"),
             DiasDaSemana(id: 2, nome: "Terça"),
              DiasDaSemana(id: 3, nome: "Quarta"),
               DiasDaSemana(id: 4, nome: "Quinta"),
                DiasDaSemana(id: 5, nome: "Sexta"),
                 DiasDaSemana(id: 6, nome: "Sabado")
        ]
        self.openSelect(array: diasDaSemana)
    }
    
    @objc func openSelectHorarios(textField: UITextField) {
        
        let horarios = [
            "06:00", "06:30", "07:00", "07:30",
            "08:00", "08:30", "09:00", "09:30",
            "10:00", "10:30", "11:00", "11:30",
            "12:00", "12:30", "12:00", "12:30",
            "13:00", "13:30", "14:00", "14:30",
            "15:00", "15:30", "16:00", "16:30",
            "17:00", "17:30", "18:00", "18:30",
            "19:00", "19:30", "20:00", "20:30",
            "21:00", "21:30", "22:00", "23:30",
            "23:00", "23:30", "24:00", "24:30"
        ]
        self.openSelect(array: horarios)
    }
    
    
    
    func setAcademia(academia: AcademiaCorporativa) {
        self.academiaSelecionada = academia
        self.tf_nome_academia.text = academia.nome
    }
    
    func setDiasDaSemana(array: [DiasDaSemana]) {
        
        self.diasDaSemanaSelecionados = []
        self.tf_dias_semana.text = ""
        
        for dia in array {
            self.diasDaSemanaSelecionados.append(dia.id!)
            self.tf_dias_semana.text = self.tf_dias_semana.text! + " " + dia.nome!
        }
    }
    
    func setHorarios(array: [String]) {
        
        self.horariosSelecionados = []
        self.tf_horarios.text = ""
        
        print(array)
        for horario in array {
            self.horariosSelecionados.append(horario)
            self.tf_horarios.text = self.tf_horarios.text! + " " + horario
        }
        
        print(self.horariosSelecionados)
    }
    
    func openSelect(array: [Any]) {
        
        if !array.isEmpty {
            
            let storyboard = UIStoryboard(name: "Corporativo", bundle: nil)
            if let controller = storyboard.instantiateViewController(withIdentifier: "DefaultTC") as? DefaultTC {
                controller.viewThatOpened = self
                controller.arrayToSelect = array
                controller.modalTransitionStyle = .coverVertical
                self.present(controller, animated: true, completion: nil)
            }
        }
        
    }
    
    func validaFormFields() {
        
    }
    
    func loadLayout() {
        
    }
    
    func formatFormToSend() -> [String : Any] {
        
        if
            (self.tf_valor.text?.isEmpty)! ||
            (self.tf_nome_aula.text?.isEmpty)! ||
            (self.tf_nome_academia.text?.isEmpty)! ||
            (self.tf_dias_semana.text?.isEmpty)! ||
            (self.tf_duracao.text?.isEmpty)! ||
            (self.tf_horarios.text?.isEmpty)! ||
            (self.tf_descricao.text?.isEmpty)! ||
            (self.tf_tags.text?.isEmpty)!
        {
           
            return [:]
        } else {
            
            let tags = self.tf_tags.text!.components(separatedBy: ",")
            let local = Local(id: self.academiaSelecionada.id!)
            let configuracao = Configuracao(valor: Valor(quantidade: Double(self.tf_valor.text!.moneyToApi()), moeda: "BRL"), horarios: self.horariosSelecionados, diasSemana: self.diasDaSemanaSelecionados, duracaoMinutos: self.tf_duracao.text!)
            let eventoToApi = EventoToApi(local: local, nome: self.tf_nome_aula.text!, descricao: self.tf_descricao.text!, tags: tags, configuracao: configuracao)
            
            let dict = eventoToApi.toJSON()
            
            print(dict)
            return dict
        }
      
    }
    
    @IBAction func registrar(_ sender: Any) {
        
        let obj = formatFormToSend()
        
        if !obj.isEmpty {
            GlobalCalls.evento(networkRequestDelegate: self, body: obj, responseHandler: ResponseHandler(startHandler: {
                self.btn_send.loadingIndicator(true, color: .black)
            }, finishHandler: {
                self.btn_send.loadingIndicator(true, color: .black)
            }, successHandler: { (result) in
                
                self.navigationController?.popViewController(animated: true)
                
            }, failureHandler: { (error) in
                
            }))
            
        } else {
             Utils.openAlert(message: "Dados incompletos!")
        }
       
    }

}
