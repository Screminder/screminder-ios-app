//
//  UIViewExt.swift
//  Screminder
//
//  Created by Abdulsamad Aliyu on 12/13/17.
//  Copyright © 2017 Abdulsamad Aliyu. All rights reserved.
//

import UIKit

@IBDesignable

class UIViewExt: UIView {

    override func awakeFromNib() {
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.3463083187)
        self.layer.borderWidth = 1.0
    }

}
