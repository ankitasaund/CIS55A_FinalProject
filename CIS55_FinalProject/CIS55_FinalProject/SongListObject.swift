//
//  SongListObject.swift
//  CIS55_FinalProject
//
//  Created by Jan on 3/10/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class SongListObject: NSObject {
    
    var songFileName = NSDataAsset(name: "")
    var songType = ""
    var songEmotion = ""
    var songImage = UIImage(named: "")
    var songDuration = Int(0)
    
    init (songFileName: NSDataAsset, songType: String, songEmotion: String, songImage: UIImage, songDuration : Int) {
    
            self.songFileName = songFileName
            self.songType = songType
            self.songEmotion = songEmotion
            self.songImage = songImage
            self.songDuration = songDuration
    }
}
