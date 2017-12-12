//
//  FirstLaunchVC.swift
//  Screminder
//
//  Created by Abdulsamad Aliyu on 12/11/17.
//  Copyright © 2017 Abdulsamad Aliyu. All rights reserved.
//

import UIKit


class FirstLaunchVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var futureScrollView: UIScrollView!
    
    @IBOutlet weak var featurePageControl: UIPageControl!
    let feature1 = ["imageName": "screen1xcode"]
    let feature2 = ["imageName": "screen2xcode"]
    let feature3 = ["imageName": "screen3xcode"]
    
    var featureArray = [Dictionary<String, String>]()
    
    var goButton: UIButton!
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goButton = {
            let button = UIButton()
            let cg = CGRect(x: (self.view.frame.width / 2) - 25, y: self.view.frame.height - 50, width: 50, height: 35)
            button.frame = cg
            button.backgroundColor = #colorLiteral(red: 0, green: 0.8392156863, blue: 0.8705882353, alpha: 1)
            button.setTitle("GO", for: .normal)
            button.layer.cornerRadius = 50/4
            button.layer.shadowRadius = 50/4
            button.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            button.layer.shadowOffset = CGSize(width: 0, height: 0)
            button.layer.shadowOpacity = 0.7
            return button
        }()
        
        futureScrollView.delegate = self
        featureArray = [feature1, feature2, feature3]
        futureScrollView.isPagingEnabled = true
        futureScrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(featureArray.count), height: self.view.bounds.height)
        futureScrollView.showsHorizontalScrollIndicator = false
        view.addSubview(goButton)
        goButton.isHidden = true
        goButton.addTarget(self, action: #selector(toHome), for: .touchUpInside)
        
        
        loadFeatures()
    }
    
    @objc func toHome(){
        guard let homeVC = storyboard?.instantiateViewController(withIdentifier: "MainVC") else{
            return
        }
        presentDetail(homeVC)
    }
    
    func loadFeatures(){
        for (index, feature) in featureArray.enumerated() {
            if let featureView = Bundle.main.loadNibNamed("FirstImage", owner: self, options: nil)?.first as? ImageViews{
                featureView.mainImageView.image = UIImage(named:feature["imageName"]!)
                futureScrollView.addSubview(featureView)
                featureView.frame.size.width = self.view.bounds.size.width
                featureView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
            }
        }
    }
    
    func actionFeature(sender: UIButton){
        
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        featurePageControl.currentPage = Int(page)
        if Int(page) == 2 {
            
            setView(view: goButton, hidden: false)
            setView(view: featurePageControl, hidden: true)
            self.view.backgroundColor = #colorLiteral(red: 0.5058823529, green: 0.8352941176, blue: 0.9058823529, alpha: 1)
        }
        else{
            if Int(page) == 0{
                self.view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.3176470588, blue: 0.3294117647, alpha: 1)
            }
            setView(view: goButton, hidden: true)
            setView(view: featurePageControl, hidden: false)
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        featurePageControl.currentPage = Int(page)
        
        if Int(page) == 2{
            setView(view: goButton, hidden: false)
            setView(view: featurePageControl, hidden: true)
        }
        else if Int(page) == 0{
            setView(view: goButton, hidden: true)
            setView(view: featurePageControl, hidden: false)
        }
    }

    func setView(view: UIView, hidden: Bool){
        UIView.transition(with: view, duration: 0.05, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        }, completion: nil)
    }


}
