//
//  Button.swift
//  TriggIos
//
//  Created by Matheus Ramos on 31/07/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setTitleWithoutAnimation(_ title: String?, for controlState: UIControlState) {
        UIView.performWithoutAnimation {
            self.setTitle(title, for: controlState)
            self.layoutIfNeeded()
        }
    }
    
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        
        let buttonTitle = self.titleLabel?.text 
        if show {
            self.isEnabled = false
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            self.setTitle("", for: .normal)
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
                self.setTitle(buttonTitle, for: .normal)
            }
        }
    }
    
    func loadingIndicator(_ show: Bool, color: UIColor) {
        let tag = 808404
        
        let buttonTitle = self.titleLabel?.text
        if show {
            self.isEnabled = false
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            self.setTitle("", for: .normal)
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            indicator.color = color
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
                self.setTitle(buttonTitle, for: .normal)
            }
        }
    }
    
    func setBorderColor(color: UIColor){
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
}
