//
//  ReminderModel.swift
//  Screminder
//
//  Created by Abdulsamad Aliyu on 12/31/17.
//  Copyright © 2017 Abdulsamad Aliyu. All rights reserved.
//

import UIKit

struct ReminderModel {
    var title: String
    var dateSet: String?
    var description: String?
    var image: UIImage?
    var daysLeft: String?
    var hoursLeft: String?
    var minutesLeft: String?
    var type: ReminderType
    var dateSetRealDate: Date
    var dateToEnd: Date
    var interval: Int?
    
    init(title: String, description: String?, image: UIImage?, type: ReminderType, dateSetRealDate: Date, dateToEnd: Date) {
        
        self.title = title
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateSet = dateFormatter.string(from: dateSetRealDate)
        if let newDescription = description {
            self.description = newDescription
        }
        if let newImage = image {
            self.image = newImage
        }
        interval = Int(dateToEnd.timeIntervalSince(dateSetRealDate))
        var minutes: Int?
        var hours: Int?
        var days: Int?
        while Int(interval!/86400) > 0{
            days = Int(interval!/86400)
            interval = interval! % 86400
        }
        while Int(interval!/3600) > 0 {
            hours = Int(interval!/3600)
            interval = interval! % 3600
        }
        while Int(interval!/60) > 0 {
            minutes = Int(interval!/60)
            interval = interval! % 60
        }
        if let newDays = days {
            if newDays < 10{
                daysLeft = "0\(newDays)"
            }
            else{
                daysLeft = "\(newDays)"
            }
        }
        else{
            daysLeft = "00"
        }
        if let newHours = hours{
            if newHours < 10{
                hoursLeft = "0\(newHours)"
            }
            else{
                hoursLeft = "\(newHours)"
            }
        }
        else{
            hoursLeft = "00"
        }
        if let newMinutes = minutes{
            if newMinutes < 10{
                minutesLeft = "0\(newMinutes)"
            }
            else{
                minutesLeft = "\(newMinutes)"
            }
        }
        else{
            minutesLeft = "00"
        }
        
        
        
        
        
        
        self.type = type
        self.dateSetRealDate = dateSetRealDate
        self.dateToEnd = dateToEnd
        
    }
}

enum ReminderType{
    case screminder
    case reminder
}
