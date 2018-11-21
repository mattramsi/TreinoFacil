//
//  Validators.swift
//  TriggIos
//
//  Created by Matheus Ramos on 22/05/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Foundation
import  UIKit

class Validators {
    
    //Validar CPF
    static func isValidCPF(textfield: UITextField!) -> Bool {
        
        let numbers: [Int]! = textfield.text?.compactMap({Int(String($0))})
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        let soma1 = 11 - ( numbers![0] * 10 +
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
    
    static func isValidPassApp(testStr: String) -> Bool {
        let regex = "[A-Za-z0-9]{8,16}"
        
        let textTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return textTest.evaluate(with: testStr)
    }
    
    static func matches(regex: String, string: String ) -> Bool {
        return string.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}


