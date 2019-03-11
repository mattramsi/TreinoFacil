//
//  TextPatternView.swift
//  TriggIos
//
//  Created by Matheus Ramos on 26/12/18.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit

class TextPatternView: UIView, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var textView_description: UITextView!
    var blurEffect: UIVisualEffectView!
    
    override func layoutSubviews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeAlert(_:)))
        tap.delegate = self // This is not required
        blurEffect.addGestureRecognizer(tap)
    }
    
    override func awakeFromNib() {
        

    }
    
    @IBAction func closeAlert(_ sender: Any) {
        
        self.blurEffect.removeFromSuperview()
        self.removeFromSuperview()
    }
}

