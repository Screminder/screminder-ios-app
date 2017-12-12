//
//  UIViewControllerExt.swift
//  Screminder
//
//  Created by Abdulsamad Aliyu on 12/12/17.
//  Copyright © 2017 Abdulsamad Aliyu. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDetail(_ viewControllerToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: nil)
    }
}
