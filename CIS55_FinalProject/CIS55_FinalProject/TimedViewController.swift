//
//  TimedViewController.swift
//  CIS55_FinalProject
//
//  Created by Nodira on 3/15/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class TimedViewController: UIViewController {
    
    @IBOutlet weak var Medit3min: UIButton!
    @IBOutlet weak var Medit10min: UIButton!
    @IBOutlet weak var Medit7min: UIButton!
    @IBOutlet weak var Medit5min: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Make buttons rounded
        makeButtonsRound(button: Medit3min)
        makeButtonsRound(button: Medit5min)
        makeButtonsRound(button: Medit7min)
        makeButtonsRound(button: Medit10min)
        
        //Align text for all buttons
        Medit3min.titleLabel?.textAlignment = NSTextAlignment.center
        Medit5min.titleLabel?.textAlignment = NSTextAlignment.center
        Medit7min.titleLabel?.textAlignment = NSTextAlignment.center
        Medit10min.titleLabel?.textAlignment = NSTextAlignment.center
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "TimedView")
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

    @IBAction func meditation3min(_ sender: Any) {
        projectUtil.duration = 180
        performSegue(withIdentifier: "PlayTimed",
                     sender: self)
    }
    
    
    @IBAction func meditation5min(_ sender: Any) {
        projectUtil.duration = 300
        performSegue(withIdentifier: "PlayTimed",
                     sender: self)
        
    }
    
    @IBAction func meditation10min(_ sender: Any) {
        projectUtil.duration = 600
        performSegue(withIdentifier: "PlayTimed",
                     sender: self)
    
    }
    
    
    @IBAction func meditation7min(_ sender: Any) {
        projectUtil.duration = 420
        performSegue(withIdentifier: "PlayTimed",
                     sender: self)
        
    }

    // MARK: - Navigation
     
     //projectUtil.originatingScreen = "quickstart"
     //performSegue(withIdentifier: "quickPlayMusic",
     //sender: self)


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        projectUtil.originatingScreen = "timedMedi"

        let playViewController = segue.destination as! playMusicViewController
        playViewController.timed = projectUtil.duration
    }
    

}
