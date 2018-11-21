//
//  Utils.swift
//  TriggIos
//
//  Created by Matheus Ramos on 15/03/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Foundation
import  UIKit

class Utils {

    //Validar CPF
    static func isValidCPF(text: String) -> Bool {

        let numbers = text.compactMap({Int(String($0))})
        print(numbers)
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        let soma1 = 11 - ( numbers[0] * 10 +
            numbers[1] * 9 +
            numbers[2] * 8 +
            numbers[3] * 7 +
            numbers[4] * 6 +
            numbers[5] * 5 +
            numbers[6] * 4 +
            numbers[7] * 3 +
            numbers[8] * 2 ) % 11
        let dv1 = soma1 > 9 ? 0 : soma1
        let soma2 = 11 - ( numbers[0] * 11 +
            numbers[1] * 10 +
            numbers[2] * 9 +
            numbers[3] * 8 +
            numbers[4] * 7 +
            numbers[5] * 6 +
            numbers[6] * 5 +
            numbers[7] * 4 +
            numbers[8] * 3 +
            numbers[9] * 2 ) % 11
        let dv2 = soma2 > 9 ? 0 : soma2
        return dv1 == numbers[9] && dv2 == numbers[10]
    }
    
    
    
    //Transformar em UIColor qualquer hexadecimal
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //Quando tiver um texto que precisa ter palavras com cores diferentes, passar o texto, a posicao inicial que sera colorida e o tamanho
    static func multiColorLabel(txt: String, posStart:Int, length: Int) -> NSMutableAttributedString {
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: txt)
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: Colors.greenTrigg, range: NSRange(location: posStart,length: length))
        
        return myMutableString
    }

    
    //Remove caracter especial
    static func getAlphaNumericValue(text: NSString) -> String{
        
        let yourString  = text
        let unsafeChars = CharacterSet.alphanumerics.inverted  // Remove the .inverted to get the opposite result.
        let cleanChars  = yourString.components(separatedBy: unsafeChars).joined(separator: "")
        
        return cleanChars
     }
    
 
    
    static func secondsToMinutes(time: String) -> String {
        let hours = Int(time)! / 3600
        let minutes = Int(time)! / 60 % 60
        let seconds = Int(time)! % 60
        
        
        if hours > 0 {
            return String(format:"%02i:h %02imin %02is", hours, minutes, seconds)
        } else if minutes > 0 {
            return String(format:"%02imin %02is", minutes, seconds)
        } else {
            return String(format:"%02is", seconds)
        }
    }
    
    static func formatCurrency(value: Any) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.currencySymbol = "R$ "
        let result = formatter.string(from: value as! NSNumber)
       
        return  result!
    }
    
    
    static func dateTimeline(string: String)  -> Array<String>{
  
        let dataHora = string.components(separatedBy: " ")

        let data = dataHora[0].components(separatedBy: "-")
        var hora = dataHora[1].components(separatedBy: ":")

        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "pt_BR") as Locale?
        let monthName = dateFormatter.monthSymbols[Int(data[1])! - 1].uppercased()

        let dataForm = data[2] + "/" + monthName.prefix(3)
        let horaForm = hora[0] + ":" + hora[1]
        let array = [dataForm, horaForm]
        
        return array
    }
    
    static func dateFatura(string: String)  -> String {
        let monthYear: String
        
        if (string != "XXX"){
            let year = string.prefix(4).suffix(2)
            let month = string.suffix(2)
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "pt_BR") as Locale?
            
            let monthName = dateFormatter.monthSymbols[Int(month)! - 1].uppercased()
            
            monthYear =  monthName.prefix(3) + "/" + year
        } else{
            monthYear = string
        }

    
        return String(monthYear)
    }
    
    static func dateBR(string: String) -> String{
        let data = string.components(separatedBy: "-")
        let dataBr = data[2] + "/" + data[1] + "/" + data[0]
        
        return dataBr
    }
    
    static func spinnerFooterTableView(show: Bool, view: UITableView){
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        if show {
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: view.bounds.width, height: CGFloat(44))
            view.tableFooterView = spinner
            view.tableFooterView?.isHidden = false
        } else {
            spinner.stopAnimating()
            view.tableFooterView = .none
            view.tableFooterView?.isHidden = true
        }
    }
    
    static func spinnerHeaderTableView(show: Bool, view: UITableView){
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        if show {
            spinner.startAnimating()
            spinner.color = Colors.greenTrigg
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: view.bounds.width, height: CGFloat(44))
            view.tableHeaderView = spinner
            view.tableHeaderView?.layer.backgroundColor = UIColor.white.cgColor
            view.tableHeaderView?.isHidden = false
        } else {
            spinner.stopAnimating()
            view.tableHeaderView = .none
            view.tableHeaderView?.isHidden = true
        }
    }
    
    static func openAlert(message: String) {
        let message = message
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        UIApplication.topViewController()?.present(alert, animated: true)
        
        let duration: Double = 1
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: true)
        }
    }
    
    //
    // Convert String to base64
    //
    static func convertImageToBase64(image: UIImage) -> String {
        let imageData = UIImagePNGRepresentation(image)!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    //
    // Convert base64 to String
    //
    static func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
    
    
    //reset UserDefaults
    static func resetDefaults() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
    
    static func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    static func setStorage(name: String, value: Any?) {
        UserDefaults.standard.set(value, forKey: name)
    }
    
    static func getStorage(name: String) -> Any {
        return UserDefaults.standard.value(forKey: name)
    }
    
    static var getClienteId: String {
        
        let clienteId = UserDefaults.standard.string(forKey: "clienteId")
        if clienteId == nil {return ""}
        else { return clienteId!}
    }
    
    static func deleteStorage(name: String) {
        return UserDefaults.standard.removeObject(forKey: name)
    }

    

}
