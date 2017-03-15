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
    
    init (songFileName: NSDataAsset, songType: String, songEmotion: String, songImage: UIImage) {
    
            self.songFileName = songFileName
            self.songType = songType
            self.songEmotion = songEmotion
            self.songImage = songImage
    }
}
