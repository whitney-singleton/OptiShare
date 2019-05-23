//
//  Settings.swift
//  OptiShare
//
//  Created by Jackson on 4/24/19.
//  Copyright © 2019 Jackson. All rights reserved.
//

import Foundation

struct currentSettings {
    static var combined:Bool = false
    
    static var useOld:Bool = true
}

class Settings : ViewController {
    
    
    /** Save settings to users defaults to preserve on relaunch */
    func saveSettings() {
        // Save Smoothing
        let stdSmoothing = UserDefaults.standard;
        stdSmoothing.set("someVariableOrString", forKey: "myKey");
        stdSmoothing.synchronize();
        
        // Save Combined bool
        let stdCombined = UserDefaults.standard;
        stdCombined.set(currentSettings.combined, forKey: "settings_combined");
        stdCombined.synchronize();
    }
}
