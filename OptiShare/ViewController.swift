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
            timeLabel.text = getTimeIg()
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
    
    /** Calculate a time based on instagram post history */
    func getTimeIg() -> String {
        let access:Accounts = Accounts()
        let postHistory:[Post] = access.getInstagramHist()
        var _ = 0
        for post in postHistory {
            return post.dateToTime()
        }
        return "0:00"
    }
    
    
}
// EoC ViewController


/** Data retrieval */
extension ViewController{
    func getTokenInsta() -> String {
        return ("TODO")
    }
}
