//
//  AboutPageViewController.swift
//  CIS55_FinalProject
//
//  Created by Patricia Caceres on 3/17/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class AboutPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    lazy var viewControllerList:[UIViewController]={
        let storyb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyb.instantiateViewController(withIdentifier: "AnkitaVC")
        let vc2 = storyb.instantiateViewController(withIdentifier: "JanVC")
        let vc3 = storyb.instantiateViewController(withIdentifier: "NodiraVC")
        let vc4 = storyb.instantiateViewController(withIdentifier: "PatVC")
        return [vc1, vc2, vc3, vc4]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstViewController = viewControllerList.first{
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard viewControllerList.count > previousIndex else {return nil}
        return viewControllerList[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        let nextIndex = vcIndex + 1
        guard viewControllerList.count != nextIndex else {return nil}
        guard viewControllerList.count > nextIndex else {return nil}
        return viewControllerList[nextIndex]
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return viewControllerList.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = viewControllerList.index(of: firstViewController) else {return 0}
        return 0
    }
    
}
