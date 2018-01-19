//
//  ShareSelectViewController.swift
//  ShareScreminder
//
//  Created by Abdulsamad Aliyu on 12/13/17.
//  Copyright © 2017 Abdulsamad Aliyu. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareSelectViewController: UIViewController{
    
    let timeForAlarm: Time = Time()
    
    lazy var hourPickerView: UIDatePicker = {
       let pickerView = UIDatePicker(frame: self.view.frame)
        pickerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pickerView.datePickerMode = .dateAndTime
        pickerView.backgroundColor = .clear
        return pickerView
    }()
    
   
    


    override func viewDidLoad() {
        super.viewDidLoad()
        timeForAlarm.time = hourPickerView.date
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        title = "Select Time"
        let currentDate = Date()
        hourPickerView.minimumDate = currentDate
        view.addSubview(hourPickerView)
//
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(donePressed))
        
        
    }
    
    @objc func donePressed(){
        TimeService.instance.time = Time()
        timeForAlarm.time = hourPickerView.date
        TimeService.instance.time?.time = timeForAlarm.time
        if let configurationItems = ShareViewController().configurationItems() as? [SLComposeSheetConfigurationItem]{
            for configurationItem in configurationItems{
                configurationItem.value = "\(TimeService.instance.time!.time!)"
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    

    
    

}


