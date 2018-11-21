//
//  StringExtensions.swift
//  TriggIos
//
//  Created by Matheus Ramos on 27/07/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Foundation

extension String {
    var withoutSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.punctuationCharacters).joined(separator: "")
    }
    
    var removingWhitespaces: String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func toDateUS() -> String? {
        if self.isEmpty {
            return ""
        } else {
            let dateBRArray = self.components(separatedBy: "/")
            let dia   = dateBRArray[0]
            let mes = dateBRArray[1]
            let ano = dateBRArray[2]
            let dateUS = ano + "-" + mes + "-" + dia
            return dateUS
        }
    }
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "R$ "
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 10))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    
    var digits: String { return components(separatedBy: CharacterSet.decimalDigits.inverted) .joined() }
    
    func moneyToApi() -> NSDecimalNumber {
        let subStrings: [String] = ["R$", "."]
        var resultString = self
        subStrings.map { resultString = resultString.replacingOccurrences(of: $0, with: "") }
        resultString = resultString.replacingOccurrences(of: ",", with: ".")
        let num = NSDecimalNumber(string: resultString)
        return num
    }

    
}



