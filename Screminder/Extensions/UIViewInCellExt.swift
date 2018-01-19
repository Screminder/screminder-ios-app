//
//  UIViewInCellExt.swift
//  Screminder
//
//  Created by Abdulsamad Aliyu on 12/27/17.
//  Copyright © 2017 Abdulsamad Aliyu. All rights reserved.
//

import UIKit

@IBDesignable

class UIViewExtInCell: UIView{
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 1
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
