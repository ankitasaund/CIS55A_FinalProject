//
//  AboutPageViewController.swift
//  CIS55_FinalProject
//
//  Created by Patricia Caceres on 3/16/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class AboutPageViewController: UIPageViewController,

    UIPageViewControllerDataSource {
    
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
        if let firstViewController = viewControllerList.first{
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
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

   
}
