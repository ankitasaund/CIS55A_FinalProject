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
    
    init (songFileName: NSDataAsset, songType: String, songEmotion: String) {
    
            self.songFileName = songFileName
            self.songType = songType
            self.songEmotion = songEmotion
    }
}
