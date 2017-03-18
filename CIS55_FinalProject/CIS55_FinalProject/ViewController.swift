//
//  ViewController.swift
//  CIS55_FinalProject
//
//  Created by Jan on 3/6/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData


class ViewController: UIViewController, NSFetchedResultsControllerDelegate  {
    
    
    @IBOutlet weak var plannerBtn: UIButton!
    @IBOutlet weak var progressBtn: UIButton!
    @IBOutlet weak var feelingBtn: UIButton!
    @IBOutlet weak var quickStart: UIButton!
    @IBOutlet weak var timedMeditationBtn: UIButton!

    var player: AVAudioPlayer? = nil
    var myPoints : [ProgressPointsObjectMO] = []
    var mySongList =
        [
            SongListObject(songFileName: NSDataAsset(name: "LovingKindness")!, songType: "guided", songEmotion: "Happy", songImage: #imageLiteral(resourceName: "Kayaking"), songDuration: 10)
            ,SongListObject(songFileName: NSDataAsset(name:"BreathingSpace")!, songType: "guided", songEmotion: "Calm", songImage: #imageLiteral(resourceName: "Westcliff"), songDuration: 3)
            ,SongListObject(songFileName: NSDataAsset(name: "WorkingwithDifficulties")!, songType: "guided", songEmotion: "Stress", songImage: #imageLiteral(resourceName: "LakeView"), songDuration: 7)
            ,SongListObject(songFileName: NSDataAsset(name: "LovingKindness")!, songType: "guided", songEmotion: "Loneliness", songImage: #imageLiteral(resourceName: "Stream"), songDuration: 10)
            
            ,SongListObject(songFileName: NSDataAsset(name: "WorkingwithDifficulties")!, songType: "guided", songEmotion: "Sad", songImage: #imageLiteral(resourceName: "LakeView"), songDuration: 7)
            ,SongListObject(songFileName: NSDataAsset(name: "BreathingSpace")!, songType: "guided", songEmotion: "Bored", songImage: #imageLiteral(resourceName: "Waterfall"), songDuration: 3)
    ]
    
    var fetchResultsController : NSFetchedResultsController<ProgressPointsObjectMO>!
    
    @IBAction func HowAreYouFeeling(_ sender: Any) {
     
        //playSound(thisSong: mySongList[0].songFileName)
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
        
        //Align text for 2 of the buttons
        timedMeditationBtn.titleLabel?.textAlignment = NSTextAlignment.center
        feelingBtn.titleLabel?.textAlignment = NSTextAlignment.center

        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "sunset")
        self.view.insertSubview(backgroundImage, at: 0)
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill;

        //JBT All lines until the end of the function
        
        let fetchRequest = NSFetchRequest<ProgressPointsObjectMO>(entityName: "ProgressPointsObject")
        
        let sortDescriptor = NSSortDescriptor(key: "progressDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            do {
                try fetchResultsController.performFetch()
                if let fetchedObjects = fetchResultsController.fetchedObjects {
                    myPoints = fetchedObjects
                }
            }
            catch {
                print(error)
            }
        }
        
        for thisProgressPoints in myPoints {
            print("Points for today \(thisProgressPoints.progressDate) \(thisProgressPoints.progressPoints)\n")
        }
 
        
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
    
    @IBAction func quickStart(_ sender: Any) {
        
        projectUtil.originatingScreen = "quickstart"
        performSegue(withIdentifier: "quickPlayMusic",
                     sender: self)
    }

}

