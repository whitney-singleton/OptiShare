//
//  Settings.swift
//  OptiShare
//
//  Created by Jackson on 4/24/19.
//  Copyright © 2019 Jackson. All rights reserved.
//

import Foundation

class Settings : ViewController {
    
    
    /** Save settings to users defaults to preserve on relaunch */
    func saveSettings() {
        // Save Smoothing
        let stdSmoothing = UserDefaults.standard;
        stdSmoothing.set("someVariableOrString", forKey: "myKey");
        stdSmoothing.synchronize();
        
        // Save Combined bool
        let stdCombined = UserDefaults.standard;
        stdCombined.set("someVariableOrString", forKey: "myKey");
        stdCombined.synchronize();
    }
}
