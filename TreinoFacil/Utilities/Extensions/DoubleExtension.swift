//
//  DoubleExtension.swift
//  TriggIos
//
//  Created by Matheus Ramos on 12/11/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {

        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
