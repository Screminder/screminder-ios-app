//
//  MainVC.swift
//  Screminder
//
//  Created by Abdulsamad Aliyu on 12/11/17.
//  Copyright © 2017 Abdulsamad Aliyu. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

var player: AVAudioPlayer?

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var remindersTableView: UITableView!
    var reminderData = [ReminderModel]()
    var updateCellsTimer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        remindersTableView.delegate = self
        remindersTableView.dataSource = self
        remindersTableView.showsVerticalScrollIndicator = false
        remindersTableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
        updateCellsTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCells), userInfo: nil, repeats: true)
        NotificationCenter.default.addObserver(self, selector: #selector(setup(notification:)), name: .done, object: nil)
        
        setData()
        
        
    }
    
    @objc func setup(notification: NSNotification){
        setData()
        remindersTableView.reloadData()
    }
    
    func setData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Reminder", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminder")
        request.returnsObjectsAsFaults = false
        reminderData = [ReminderModel]()
        
        do{
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject]{
                let title = data.value(forKey: "title") as! String

                let description = data.value(forKey: "descriptionText") as Any
                let imageData = try data.value(forKey: "image") as Any
                let isScreminder = data.value(forKey: "isScreminder") as! Bool
                let dateSet = data.value(forKey: "dateSet") as! Date
                let dateToEnd = data.value(forKey: "dateToEnd") as! Date
                print("Title: ", title)
            
                print("Is Screminder or not: ", isScreminder)
                
                if isScreminder == true{
                    let image = UIImage(data: imageData as! Data    )
                    let newReminder = ReminderModel(title: title, description: nil, image: image, type: .screminder, dateSetRealDate: dateSet, dateToEnd: dateToEnd)
                    reminderData.append(newReminder)
                }
                else{
                    let newReminder = ReminderModel(title: title, description: description as! String, image: nil, type: .reminder, dateSetRealDate: dateSet, dateToEnd: dateToEnd)
                    reminderData.append(newReminder)
                }
            }
            reminderData = reminderData.reversed()
        }
        catch {
            print("Failed")
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSound(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Reminder", in: context)
        let url = Bundle.main.url(forResource: "iphone_alarm", withExtension: "mp3")!
        do{
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else{
                return
            }
            player.prepareToPlay()
            player.play()
        }
        catch let error as NSError {
            print(error.description)
        }
        
    }
    
    func stopSound(){
        player?.stop()
    }
    
    @objc func updateCells(){
        let indexPathsArray = remindersTableView.indexPathsForVisibleRows
        for indexpath in indexPathsArray! {
            let cell = remindersTableView.cellForRow(at: indexpath) as! ReminderTableViewCell
            let cellData = reminderData[indexpath.row]
            var interval = Int(cellData.dateToEnd.timeIntervalSince(Date()))
//            print("Interval: ", interval)
            var originalInterval = Int(cellData.dateToEnd.timeIntervalSince(cellData.dateSetRealDate))
            if interval == 0{
                let seeDetail = ViewScreminderViewController()
                seeDetail.modalPresentationStyle = .overCurrentContext
                let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.crossDissolve
                seeDetail.modalTransitionStyle = modalStyle
                present(seeDetail, animated: true) {
                    seeDetail.setupView(screminder: self.reminderData[indexpath.row])
                    self.playSound()
                }
            }
            cell.updateTimer(interval: interval, originalInterval: originalInterval)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let seeDetail = ViewScreminderViewController()
        seeDetail.modalPresentationStyle = .overCurrentContext
        let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.crossDissolve
        seeDetail.modalTransitionStyle = modalStyle
        present(seeDetail, animated: true) {
            seeDetail.setupView(screminder: self.reminderData[indexPath.row])
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminderData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as? ReminderTableViewCell{
            
            cell.setupViews(reminderModel: reminderData[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
            
            let toDeleteFromArray = self.reminderData[indexPath.row]
            let dateToDelete = toDeleteFromArray.dateSetRealDate
            
            self.deleteObjectFromCoreData(dateToDelete: dateToDelete)
            self.reminderData.remove(at: indexPath.row)
            self.remindersTableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: UITableViewRowAnimation.fade)
            
        }
        return [more]
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellData = reminderData[indexPath.row]
        let interval = Int(cellData.dateToEnd.timeIntervalSince(Date()))
        //            print("Interval: ", interval)
        if let newCell = cell as? ReminderTableViewCell{
            if interval < 1{
                newCell.showOverlay()
            }
            else{
                newCell.hideOverlay()
            }
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let addVC = AddViewController()
        addVC.modalPresentationStyle = .overCurrentContext
        let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.crossDissolve
        addVC.modalTransitionStyle = modalStyle
        
        present(addVC, animated: true, completion: nil)
    }
    
    func deleteObjectFromCoreData(dateToDelete: Date){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminder")
        request.returnsObjectsAsFaults = false
        if let result = try? context.fetch(request){
            for data in (result as? [NSManagedObject])!{
                if (data.value(forKey: "dateSet") as! Date) == dateToDelete{
                    context.delete(data)
                    do{
                        try context.save()
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }

}

extension Notification.Name{
    static let done = Notification.Name("done")
}

