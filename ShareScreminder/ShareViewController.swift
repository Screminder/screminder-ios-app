//
//  ShareViewController.swift
//  ShareScreminder
//
//  Created by Abdulsamad Aliyu on 12/13/17.
//  Copyright © 2017 Abdulsamad Aliyu. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
    
    var timeForAlarm: Time = Time()
    
    override func viewDidLoad() {
        let imageView = UIImageView(image: UIImage(named:"log"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: self.view.frame.width/2, y: 5, width: 30, height: 30)
        navigationItem.titleView = imageView
        navigationController?.navigationBar.topItem?.titleView = imageView
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.6588235294, blue: 0.7529411765, alpha: 1)
    }

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        if let time = TimeService.instance.time{
//            timeForAlarm?.time = time.time
//        }
//    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        if let time = TimeService.instance.time{
//            timeForAlarm?.time = time.time
//        }
//        print("View did appear here")
//    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("View appeared")
        for item in (self.navigationController?.navigationBar.items)!{
            if let rightItem = item.rightBarButtonItem{
                rightItem.title = "Save"
                break
            }
        }
//        print("TimeService Time: ", TimeService.instance.time)
//        timeForAlarm.time = TimeService.instance.time.time
//        print("Time: ", timeForAlarm.time)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("View will appear")
    }
    
    
    
    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        print("Configuration Items")
        if let deck = SLComposeSheetConfigurationItem(){
            deck.title = "In (time)"
            deck.value = "X hours Y minutes"
            if TimeService.instance.time != nil{
                deck.value = "\(TimeService.instance.time!.time!)"
            }
            deck.tapHandler = {
                let vc = ShareSelectViewController()
                
                self.pushConfigurationViewController(vc)
                
                
            }
            
            return [deck]
        }
        
        return nil
    }

}
