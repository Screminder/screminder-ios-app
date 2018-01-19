//
//  ViewScreminderViewController.swift
//  Screminder
//
//  Created by Abdulsamad Aliyu on 12/31/17.
//  Copyright © 2017 Abdulsamad Aliyu. All rights reserved.
//

import UIKit

class ViewScreminderViewController: UIViewController {

    @IBOutlet weak var descriptionImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UILabel!
    @IBOutlet weak var minutesTextView: UILabel!
    @IBOutlet weak var colon2: UILabel!
    @IBOutlet weak var hoursTextView: UILabel!
    @IBOutlet weak var colon1: UILabel!
    @IBOutlet weak var daysTextView: UILabel!
    @IBOutlet weak var dateTextView: UILabel!
    @IBOutlet weak var titleTextView: UILabel!
    @IBOutlet weak var bgview: UIView!
    var timer = Timer()
    var reminder: ReminderModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        bgview.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func backgroundTapped (){
        let mainVC = MainVC()
        mainVC.stopSound()
        dismiss(animated: true, completion: nil)
    }
    func setupView(screminder: ReminderModel){
        titleTextView.text = screminder.title
        dateTextView.text = screminder.dateSet
        reminder = screminder
        let cellData = reminder
        
        var interval = Int((cellData?.dateToEnd.timeIntervalSince(Date()))!)
        var originalInterval = Int((cellData?.dateToEnd.timeIntervalSince((cellData?.dateSetRealDate)!))!)
        
        updateTimer(interval: interval, originalInterval: originalInterval)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        if screminder.type == .screminder {
            descriptionImageView.isHidden = false
            descriptionTextView.isHidden = true
            descriptionImageView.image = screminder.image
        }
        else{
            descriptionImageView.isHidden = true
            descriptionTextView.isHidden = false
            descriptionTextView.text = screminder.description
        }
    }
    
    @objc func update(){
        let cellData = reminder
        
        var interval = Int((cellData?.dateToEnd.timeIntervalSince(Date()))!)
        var originalInterval = Int((cellData?.dateToEnd.timeIntervalSince((cellData?.dateSetRealDate)!))!)
        
        updateTimer(interval: interval, originalInterval: originalInterval)
    }
    
    func updateTimer(interval: Int, originalInterval: Int){
        
        
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

}
