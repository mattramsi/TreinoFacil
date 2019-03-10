//
//  ArrayExtension.swift
//  TriggIos
//
//  Created by Matheus Ramos on 07/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Foundation
import UIKit

extension Array {
    func find(includedElement: (Validatable) -> Bool) -> Int? {
        for (idx, element) in self.enumerated() {
            if includedElement(element as! Validatable) {
                return idx
            }
        }
        return nil
    }
   

}

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = index(of: object) else {return}
        remove(at: index)
    }
    
}
