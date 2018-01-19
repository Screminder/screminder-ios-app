//
//  AddViewController.swift
//  Screminder
//
//  Created by Abdulsamad Aliyu on 1/5/18.
//  Copyright © 2018 Abdulsamad Aliyu. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {

    @IBOutlet weak var mainView: UIViewExtInCell!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bgTapped))

        bgView.addGestureRecognizer(tapGestureRecognizer)
        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height/2 - 30
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height/2 + 30
            }
        }
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
         NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    @objc func bgTapped(){
        removeObservers()
        dismiss(animated: true, completion: nil)
    }

    @IBAction func savePressed(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entinty = NSEntityDescription.entity(forEntityName: "Reminder", in: context)
        if let description = descriptionTextView.text as? String, let title = titleTextView.text as? String, let date = datePickerView.date as? Date{
            let newReminder = NSManagedObject(entity: entinty!, insertInto: context)
            newReminder.setValue(title, forKey: "title")
            newReminder.setValue(description, forKey: "descriptionText")
            newReminder.setValue(nil, forKey: "image")
            newReminder.setValue(Date(), forKey: "dateSet")
            newReminder.setValue(date, forKey: "dateToEnd")
            newReminder.setValue(false, forKey: "isScreminder")
            do{
                try context.save()
                removeObservers()
                dismiss(animated: true, completion: {
                    NotificationCenter.default.post(Notification(name: .done, object: nil, userInfo: [:]))
                })
            }
            catch{
                print("Failed Saving")
            }

            
            
        }
    }
    @IBAction func closePressed(_ sender: Any) {
        removeObservers()
        dismiss(animated: true, completion: nil)
        
    }
    

}
