//
//  ViewController.swift
//  CIS55_FinalProject
//
//  Created by Jan on 3/6/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var plannerBtn: UIButton!
    @IBOutlet weak var progressBtn: UIButton!
    @IBOutlet weak var feelingBtn: UIButton!
    @IBOutlet weak var quickStart: UIButton!
    @IBOutlet weak var timedMeditationBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        // Make the buttons Rounded
        makeButtonsRound(button: timedMeditationBtn)
        makeButtonsRound(button: quickStart)
        makeButtonsRound(button: feelingBtn)
        makeButtonsRound(button: progressBtn)
        makeButtonsRound(button: plannerBtn)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "firstscreen_background")
        self.view.insertSubview(backgroundImage, at: 0)
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeButtonsRound(button: UIButton)
    {
        button.layer.cornerRadius = button.frame.size.width/2
        button.clipsToBounds = true
        button.layer.masksToBounds = true
 
    }


}

