//
//  GenericViewController.swift
//  CIS55_FinalProject
//
//  Created by Patricia Caceres on 3/22/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class GenericViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let background = CAGradientLayer().skyColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at: 0)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
