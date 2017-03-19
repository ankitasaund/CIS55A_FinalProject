//
//  playMusicViewController.swift
//  CIS55_FinalProject
//
//  Created by Prashant Saund on 3/13/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData
//import projectUtil

class playMusicViewController: UIViewController {

    
    var audioPlayer : AVAudioPlayer!
    var isPlaying = false
    var isPaused = false
    var timed = 0.0
    var isNew = true
    
    var currentUrl : URL!
    var newProgressPoints : ProgressPointsObjectMO!

    var img_1: UIImage!
    var img_2: UIImage!
    var img_3: UIImage!
    var images: [UIImage]!
    var animatedImage: UIImage!
    
    @IBOutlet var animView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let background = CAGradientLayer().skyColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at: 0)

        
        img_1 = UIImage(named: "natureback-1")
        img_2 = UIImage(named: "zen-meditation")
        img_3 = UIImage(named: "natureback")
        images = [img_1, img_2, img_3]
      
        
        //add fly-in animation for Image
        
        //var rotationTransform : CATransform3D = CATransform3DIdentity
        //rotationTransform = CATransform3DTranslate(rotationTransform, -250, -250, 0)
        //animView.layer.transform = rotationTransform
        //UIView.animate(withDuration: 6, animations: {
        //    self.animView?.layer.transform = CATransform3DIdentity
        //})
        
        animatedImage = UIImage.animatedImage(with: images, duration: 9.0)
        animView.image = animatedImage
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stopAfterNminutes(){
        audioPlayer.stop()
    }

    
    @IBAction func play(_ sender: Any) {
        
        if projectUtil.originatingScreen == "quickstart" {
            if !isPaused
            {
                var songPathsArr = getSongName()
                let range: UInt32 = UInt32(songPathsArr.count)
                let number = Int(arc4random_uniform(range))
                
                //print(songPathsArr[number])
                let path = Bundle.main.path(forResource: songPathsArr[number] as String, ofType: "mp3")
                //print(path)
                
                let url = NSURL.fileURL(withPath: path!)
                currentUrl = url
            }
            do {
                //stop earlier playing song if any
                if isPlaying{
                    audioPlayer.stop()
                }
                audioPlayer = try AVAudioPlayer(contentsOf: currentUrl)
                audioPlayer.play()
                isPlaying = true
                var audioPlayerTimer = Timer()
                //set the timer for 300 sec/5 min
                audioPlayerTimer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: "stopAfterNminutes", userInfo: nil, repeats: false)
                } catch {
                // couldn't load file :(
                print("unable to play")
            }//do catch ends
            
        }
            // nodira's code
        else if projectUtil.originatingScreen == "timedMedi" {
            if !isPaused
            {
                var songPathsArr = getSongName()
                let range: UInt32 = UInt32(songPathsArr.count)
                let number = Int(arc4random_uniform(range))
                
                //print(songPathsArr[number])
                let path = Bundle.main.path(forResource: songPathsArr[number] as String, ofType: "mp3")
                //print(path)
                
                let url = NSURL.fileURL(withPath: path!)
                currentUrl = url
            }
            do {
                //stop earlier playing song if any
                if isPlaying{
                    audioPlayer.stop()
                }
                audioPlayer = try AVAudioPlayer(contentsOf: currentUrl)
                audioPlayer.play()
                isPlaying = true
                var audioPlayerTimer = Timer()
                //set the timer for 300 sec/5 min
                audioPlayerTimer = Timer.scheduledTimer(timeInterval: timed, target: self, selector: "stopAfterNminutes", userInfo: nil, repeats: false)

            } catch {
                // couldn't load file :(
                print("unable to play")
            }//do catch ends

        }
            
            // Jane's code
        else if projectUtil.originatingScreen == "hrufeeling" {
            if (audioPlayer == nil) {
                addPoints(numOfPoints: Int(projectUtil.duration), totalTime: Int(projectUtil.duration))
                playSoundAsset(thisSong : projectUtil.songFileName)
            }
            else {
                audioPlayer.play()
            }
            isPlaying = true
        }
    }  // func play ends
    
    //get the song names from folder Songs
    func getSongName() -> [String] {
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        var songPathsArr = [String]()
        //get the name of all songs
        do{
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for song in songPath
            {
                //convert URl to string
                var mySong = song.absoluteString
                
                //make sure there is song
                if mySong.contains(".mp3")
                {
                    //print(mySong)
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count-1]
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    //print(mySong)
                    
                    songPathsArr.append(mySong)
                }//if ends
                
            } //for ends
        } //do ends
        catch{
            print("File not found")
        }
        return songPathsArr
    }  // func getSongName ends
    
    @IBAction func pause(_ sender: Any) {
        
        if isPlaying
        {
            isPaused = true
            audioPlayer.pause()
        }
    }
    
    @IBAction func replay(_ sender: Any) {
        if isPlaying{
            audioPlayer.currentTime = 0
            
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        if isPlaying
        {
            audioPlayer.stop()
        }
    }
    
    //control volume using slider
    @IBAction func controlVolume(_ sender: UISlider) {
        if isPlaying
        {
        audioPlayer.volume = sender.value
        }
    }
    
    func addPoints(numOfPoints : Int, totalTime : Int) {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            newProgressPoints = ProgressPointsObjectMO(context: appDelegate.persistentContainer.viewContext)
            
            newProgressPoints.progressTotalTime = Int16(totalTime)
            newProgressPoints.progressPoints = Int16(numOfPoints)
            newProgressPoints.progressDate = Date() as NSDate?
            appDelegate.saveContext()
            print("Progress Points Added")
            
            
        }

    }
    func playSoundAsset(thisSong: NSDataAsset?) {
        
        
        guard let sound = thisSong else {
            print("asset not found")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(data: sound.data, fileTypeHint: AVFileTypeMPEGLayer3)
            
            audioPlayer?.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isPlaying
        {
            audioPlayer.stop()
        }
    }
}
