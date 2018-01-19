//
//  ReminderTableViewCell.swift
//  Screminder
//
//  Created by Abdulsamad Aliyu on 12/27/17.
//  Copyright © 2017 Abdulsamad Aliyu. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {
    @IBOutlet weak var overlay: UIView!
    @IBOutlet weak var descriptionTextView: UILabel!
    @IBOutlet weak var descriptionImageView: UIImageView!
    @IBOutlet weak var dateTextView: UILabel!
    
    @IBOutlet weak var colon2: UILabel!
    @IBOutlet weak var colon1: UILabel!
    @IBOutlet weak var titleTextView: UILabel!
    @IBOutlet weak var minutesTextView: UILabel!
    @IBOutlet weak var hoursTextView: UILabel!
    @IBOutlet weak var daysTextView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func hideOverlay(){
        overlay.isHidden = true
    }
    
    func showOverlay(){
        overlay.isHidden = false
    }
    
    func updateTimer(interval: Int, originalInterval: Int){
        
        if interval < 1{
            overlay.isHidden = false
        }
        var timeBomb = returnFormatted(interval: interval)
        daysTextView.text = timeBomb[0]
        hoursTextView.text = timeBomb[1]
        minutesTextView.text = timeBomb[2]
        if Double(Double(interval)/Double(originalInterval)) < 0.3{
            colon1.textColor = #colorLiteral(red: 0.8823529412, green: 0.0100302999, blue: 0, alpha: 1)
            colon2.textColor = #colorLiteral(red: 0.8823529412, green: 0.0100302999, blue: 0, alpha: 1)
            daysTextView.textColor = #colorLiteral(red: 0.8823529412, green: 0.0100302999, blue: 0, alpha: 1)
            hoursTextView.textColor = #colorLiteral(red: 0.8823529412, green: 0.0100302999, blue: 0, alpha: 1)
            minutesTextView.textColor = #colorLiteral(red: 0.8823529412, green: 0.0100302999, blue: 0, alpha: 1)
        }
        
    }
    
    func returnFormatted(interval: Int) -> [String] {
        var days = 0
        var hours = 0
        var minutes = 0
        var dayString = ""
        var hoursString = ""
        var minutesString = ""
        var newInterval = interval
//        86400
        while Int(newInterval/86400) > 0 {
            days = days + Int(newInterval/86400)
            newInterval = newInterval % 86400
        }
        //        hoursTextView.text = "00"
        while Int(newInterval/3600) > 0 {
            hours = hours + Int(newInterval/3600)
            newInterval = newInterval % 3600
        }
        //        minutesTextView.text = "00"
        while Int(newInterval/60) > 0 {
            minutes = minutes + Int(newInterval/60)
            newInterval = newInterval % 60
        }
        if days < 10{
            dayString = "0\(days)"
        }
        else{
            dayString = "\(days)"
        }
        if hours < 10{
            hoursString = "0\(hours)"
        }
        else{
            hoursString = "\(hours)"
        }
        if minutes < 10{
            minutesString = "0\(minutes)"
        }
        else{
            minutesString = "\(minutes)"
        }
        return [dayString, hoursString, minutesString]
    }
    
    func setupViews(reminderModel: ReminderModel){
        titleTextView.text = reminderModel.title
        dateTextView.text = reminderModel.dateSet
        daysTextView.text = reminderModel.daysLeft
        hoursTextView.text = reminderModel.hoursLeft
        minutesTextView.text = reminderModel.minutesLeft
        if reminderModel.type == .reminder {
            descriptionImageView.isHidden = true
            descriptionTextView.isHidden = false
            descriptionTextView.text = reminderModel.description!
        }
        else{
            descriptionTextView.isHidden = true
            descriptionImageView.isHidden = false
            descriptionImageView.image = reminderModel.image!
        }
    }

}
