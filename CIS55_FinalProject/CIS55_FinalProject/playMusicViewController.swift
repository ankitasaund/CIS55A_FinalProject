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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //add background to view
        /*  let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
         backgroundImage.image = #imageLiteral(resourceName: "natureback")
         self.view.insertSubview(backgroundImage, at: 0)
         backgroundImage.contentMode = UIViewContentMode.scaleAspectFill;
         
         */
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
                audioPlayerTimer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: "stopAfter5minutes", userInfo: nil, repeats: false)
                func stopAfter5minutes(){
                    audioPlayer.stop()
                }
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
                audioPlayerTimer = Timer.scheduledTimer(timeInterval: timed, target: self, selector: "stopAfter5minutes", userInfo: nil, repeats: false)
                func stopAfter5minutes(){
                    audioPlayer.stop()
                }
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
    
    //control volume using slider
    @IBAction func controlVolume(_ sender: UISlider) {
        
        audioPlayer.volume = sender.value
        
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
    

    
}
