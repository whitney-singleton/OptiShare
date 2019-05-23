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
    
    // The main label for ideal time display
    @IBOutlet weak var timeLabel: UILabel!
    
    // The selected segment for home screen time display
    @IBOutlet weak var timeDisplaySegment: UISegmentedControl!
    
    // The currently selected segment
    public var selectedAuthSegment = 1
    
    // Which account should be loaded
    @IBOutlet weak var acctLoadSelect: UISegmentedControl!
    
    // The Accounts object for handling login
    var acct = Accounts()
    
    
    /* Begin class */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        if (timeLabel != nil) {
            displayTime()
            print("updated time disp.")
        }
    }
    
    /** Get selected account to load*/
    public func getAcctLoad() {
        selectedAuthSegment = acctLoadSelect?.selectedSegmentIndex ?? 0;
    }
    
    /** On Authorize button click launch authorization on acct object */
    @IBAction func authorize(_ sender: Any) {
        acct.newInstagram()
    }
    
    /** Called on time display segment value changed */
    @IBAction func timeDispSegChanged(_ sender: Any) {
        displayTime()
    }
    
    /** Decide which account to show time for */
    func displayTime() {
        switch (timeDisplaySegment?.selectedSegmentIndex) {
        case 0:         timeLabel.text = idealTime.instagramTime
        case 1:         timeLabel.text = idealTime.facebookTime
        case 2:         timeLabel.text = idealTime.linkedinTime
        default: timeLabel.text = "error"
        }
    }
}
// EoC ViewController
