//
//  RoundButton.swift
//  Screminder
//
//  Created by Abdulsamad Aliyu on 1/6/18.
//  Copyright © 2018 Abdulsamad Aliyu. All rights reserved.
//

import UIKit


@IBDesignable
class RoundButton: UIButton {

    override func awakeFromNib() {
        setupViews()
    }
    
    override func layoutIfNeeded() {
        setupViews()
    }
    
    func setupViews(){
        self.layer.cornerRadius = 30
        self.layer.shadowColor = #colorLiteral(red: 0.3288840877, green: 0.3328465466, blue: 0.3328465466, alpha: 1)
        self.layer.shadowOpacity = 0.5
        
    }

}
