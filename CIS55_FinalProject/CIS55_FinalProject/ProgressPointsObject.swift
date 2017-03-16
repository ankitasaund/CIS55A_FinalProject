//
//  ProgressPointsObject.swift
//  CIS55_FinalProject
//
//  Created by Jan on 3/15/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class ProgressPointsObject: NSObject {

    var progressPoints : Int = 0
    var progressDate : Date
    var progressTotalTime : Int
    
    init (progressPoints: Int, progressDate: Date, progressTotalTime: Int) {
        
        self.progressPoints = progressPoints
        self.progressDate = Date()
        self.progressTotalTime = progressTotalTime
    }

    
}
