//
//  ViewController.swift
//  CIS55_FinalProject
//
//  Created by Jan on 3/6/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    //CHANGE
    var asdasd = "Dog"
    
    @IBOutlet weak var plannerBtn: UIButton!
    @IBOutlet weak var progressBtn: UIButton!
    @IBOutlet weak var feelingBtn: UIButton!
    @IBOutlet weak var quickStart: UIButton!
    @IBOutlet weak var timedMeditationBtn: UIButton!

    var player: AVAudioPlayer? = nil
    var mySongList =
        [
            SongListObject(songFileName: NSDataAsset(name: "Guided")!, songType: "guided", songEmotion: "sad")
            ,SongListObject(songFileName: NSDataAsset(name:"Nature")!, songType: "sounds", songEmotion: "anxious")
            ,SongListObject(songFileName: NSDataAsset(name: "RelaxingMusic")!, songType: "sounds", songEmotion: "calm")
    ]
    
    @IBAction func HowAreYouFeeling(_ sender: Any) {
     
        playSound(thisSong: mySongList[0].songFileName)
    
    }
    
    func playSound(thisSong: NSDataAsset?) {
        
        
        guard let sound = thisSong else {
            print("asset not found")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(data: sound.data, fileTypeHint: AVFileTypeMPEGLayer3)
            
            player?.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
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

