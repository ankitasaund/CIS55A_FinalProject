//
//  CAGradientLayer.swift
//  CIS55_FinalProject
//
//  Created by Patricia Caceres on 3/18/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    func skyColor () -> CAGradientLayer{
        
        let topColor=UIColor(red:(188/255.0),green: (185/255.0), blue:(192/255.0),alpha: 1)
        let bottomColor=UIColor(red:(177/255.0),green: (141/255.0), blue:(143/255.0),alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.cgColor,bottomColor.cgColor]
        let gradientLocations: [Float]=[0.0,1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        return gradientLayer
        
        
    }
    
}
