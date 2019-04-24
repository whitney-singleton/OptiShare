//
//  ViewController.swift
//  OptiShare
//
//  Created by Jackson on 4/17/19.
//  Copyright © 2019 Jackson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /** Begin class variables */
    @IBOutlet weak var timeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timeLabel.text = "0:00";
    }

    /** Response to authorize instagram button.
        * Follows instagram client-side (implicit) authorization
        * rules.
    */
    @IBAction func authInstagram(_ sender: Any) {
        // TODO authorize instagram externally.
        print ("auth instagram");
    }
    
}

