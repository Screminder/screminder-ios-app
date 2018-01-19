//
//  FirstPageVC.swift
//  Screminder
//
//  Created by Abdulsamad Aliyu on 12/12/17.
//  Copyright © 2017 Abdulsamad Aliyu. All rights reserved.
//

import UIKit

class FirstPageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    lazy var viewControllerList:[UIViewController] = {
       let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "First")
        let vc2 = sb.instantiateViewController(withIdentifier: "Second")
        let vc3 = sb.instantiateViewController(withIdentifier: "Third")
        return [vc1, vc2, vc3]
    }()
    
    var goButton: UIButton?
    
    
    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        goButton = {
            let button = UIButton()
            button.frame = CGRect(x: self.view.frame.width/2 - 25, y: self.view.frame.height - 50, width: 50, height: 35)
            button.setTitle("GO", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0.8392156863, blue: 0.8705882353, alpha: 1)
            button.layer.cornerRadius = 50/4
            button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            button.layer.shadowOffset = CGSize(width: 0, height: 0)
            button.layer.shadowRadius = 50/4
            button.layer.shadowOpacity = 0.4
            
            return button
        }()
        
        self.dataSource = self
        if let firstViewController = viewControllerList.first{
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        self.view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.3176470588, blue: 0.3294117647, alpha: 1)
        self.view.addSubview(goButton!)
        goButton?.isHidden = true
        goButton?.addTarget(self, action: #selector(toHome), for: .touchUpInside)
        configurePageControl()
    }
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = viewControllerList.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = viewControllerList.index(of: pageContentViewController)!
        print("VC index: ", viewControllerList.index(of: pageContentViewController)!)
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        guard let vcIndex = viewControllerList.index(of: viewController) else{
            return nil
        }
        pageControl.currentPage = Int(vcIndex)
        print("Before: VCIndex: ", vcIndex)
        
        if vcIndex == 2{
            self.pageControl.isHidden = true
            self.goButton?.isHidden = false
            self.view.backgroundColor = #colorLiteral(red: 0.5058823529, green: 0.8352941176, blue: 0.9058823529, alpha: 1)
        }
        else{
            self.pageControl.isHidden = false
            self.goButton?.isHidden = true
            self.view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.3176470588, blue: 0.3294117647, alpha: 1)
        }
        
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else{
            return nil
        }
        guard viewControllerList.count > previousIndex else{
            return nil
        }
        
        
        return viewControllerList[previousIndex]
    }
    
    @objc func toHome() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        presentDetail(homeViewController)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.index(of: viewController) else{
            return nil
        }
        
        let nextIndex = vcIndex + 1
        
        pageControl.currentPage = Int(vcIndex)
        print("After VCIndex: ", vcIndex)
        
        if vcIndex == 2 {
            self.pageControl.isHidden = true
            self.goButton?.isHidden = false
            self.view.backgroundColor = #colorLiteral(red: 0.5058823529, green: 0.8352941176, blue: 0.9058823529, alpha: 1)
        }
        else{
            self.pageControl.isHidden = false
            self.goButton?.isHidden = true
            self.view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.3176470588, blue: 0.3294117647, alpha: 1)
        }
        
        guard viewControllerList.count != nextIndex else{
            return nil
        }
        guard viewControllerList.count > nextIndex else{
            return nil
        }
        
        
        
        return viewControllerList[nextIndex]
    }
}
