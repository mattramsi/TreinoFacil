//
//  UIViewControllerExtension.swift
//  TriggIos
//
//  Created by Matheus Ramos on 26/04/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() { view.endEditing(true) }
    
    var className: String { return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!; }
    
    func addInputAccessoryForTextFields(textFields: [UITextField], dismissable: Bool = true, previousNextable: Bool = false) {
        
        let size = CGSize(width: 20.0, height: 20.0)
        var arrowUp = UIImage(named: "up-arrow")?.withRenderingMode(.alwaysOriginal)
        var arrowDown = UIImage(named: "down-arrow")?.withRenderingMode(.alwaysOriginal)
        arrowUp = arrowUp?.resizeImage(image: arrowUp!, targetSize: size)
        arrowDown = arrowUp?.resizeImage(image: arrowDown!, targetSize: size)
        
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        for (index, textField) in textFields.enumerated() {
            
            let toolbar: UIToolbar = UIToolbar()
            toolbar.sizeToFit()
            
            var items = [UIBarButtonItem]()
            if previousNextable {
                let previousButton = UIBarButtonItem(image: arrowUp, style: .plain, target: nil, action: nil)
                previousButton.tintColor = UIColor.black
                
                if textField == textFields.first {
                    previousButton.isEnabled = false
                } else {
                    previousButton.target = textFields[index - 1]
                    previousButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                let nextButton = UIBarButtonItem(image: arrowDown, style: .plain, target: nil, action: nil)
                nextButton.tintColor = UIColor.black
                
                if textField == textFields.last {
                    nextButton.isEnabled = false
                } else {
                    nextButton.target = textFields[index + 1]
                    nextButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                let titleBtn = UIBarButtonItem(title: textField.placeholder, style: .plain, target: nil, action: nil)
                titleBtn.tintColor = UIColor.darkGray
                titleBtn.isEnabled = false
                items.append(contentsOf: [previousButton, nextButton, spacer, titleBtn, spacer])
            }
            
            let doneButton = UIBarButtonItem(title: "Ok", style: .done , target: view, action: #selector(UIView.endEditing))
            doneButton.tintColor = Colors.greenTrigg
            items.append(contentsOf: [spacer, doneButton])
            toolbar.setItems(items, animated: false)
            textField.inputAccessoryView = toolbar
        }
    }
    
    
}
