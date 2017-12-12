//
//  UIApplicationExt.swift
//  Screminder
//
//  Created by Abdulsamad Aliyu on 12/11/17.
//  Copyright © 2017 Abdulsamad Aliyu. All rights reserved.
//

import UIKit

private var firstLaunch: Bool = false

extension UIApplication {
    static func isFirstLaunch() ->Bool {
        let firstLaunchFlag = "isFirstLaunchFlag"
        let isFirstLaunch = UserDefaults.standard.string(forKey: firstLaunchFlag) == nil
        if isFirstLaunch {
            firstLaunch = isFirstLaunch
            UserDefaults.standard.set("false", forKey: firstLaunchFlag)
            UserDefaults.standard.synchronize()
        }
        return firstLaunch || isFirstLaunch
    }
}
