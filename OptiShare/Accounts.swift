//
//  Accounts.swift
//  OptiShare
//
//  Created by Jackson on 4/24/19.
//  Copyright © 2019 Jackson. All rights reserved.
//

import Foundation
import UIKit
import WebKit

import SwiftInstagram
import FacebookLogin
import FacebookCore

class Accounts : UINavigationController {
    
    // Main web view for log in to accounts
    @IBOutlet weak var loginView: WKWebView!
    
    // Whether there is currently an attempt to load an API
    var isLoading = false
    
    // All posts by instagram stored as an array of Post objects
    var aInstaPosts = [Post]()
    
    // All posts by facebook stored as an array of Post objects
    var aFbPosts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = WKWebViewConfiguration()
        if (!isLoading && ViewInfo.acctLoginSelect == 0) {
            newInstagram()
        } else if (!isLoading && ViewInfo.acctLoginSelect == 1) {
            newFacebook()
        }
        
        print ("Defined acct view");
    }
    
    /** Create a new instagram authorization request */
    /** call to init auth request */
    func newInstagram() {
        let api = Instagram.shared
        isLoading = !isLoading
        
        print("attempting api auth") //TODO del for release
        // Login & immediately update getMedia on success
        api.login(from: self, success: {
            print ("login successful: ")
            print(api.isAuthenticated)
            self.getMediaInst()
            
            // Save token globally
            let stdToken = UserDefaults.standard;
            stdToken.set(api.retrieveAccessToken()!, forKey: "ig_auth_token");
            stdToken.synchronize();
            
            // Exit web view
            self.dismiss(animated: true) {
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        }, failure: { error in
            print(error.localizedDescription)
        })
        
        // Verify authentication
        print(api.isAuthenticated)
    }
    
    /** Get recent media once login is confirmed only - makes all calles to Regression to init a time */
    func getMediaInst() {
        let api = Instagram.shared
        
        api.recentMedia(fromUser: "self", count: 10, success: { mediaList in
            print("likes: ")
            
            // Make a Post object for each found post -> add to aInstaPosts
            for post in mediaList {
                print(post.createdDate)
                print(post.likes.count)
                self.aInstaPosts.append(Post(likes: post.likes.count, date: post.createdDate))
            }
            
            // Run a model on all found posts - Regression will set display value
            let model = Regression(posts: self.aInstaPosts, type: 1)
            model.runAlg()
            
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    func newFacebook() {
        // Init login button display
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        // Init on close obtain graphs data
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me/posts")) { httpResponse, result in
            switch result {
            case .success(let response):
                print("Graph Request Succeeded: \(response)")
                let split = response.stringValue!.split(separator: " ")
                var like = false; var time = false
                var rLike = ""; var rTime = ""
                
                // Parse for key pieces of json
                for r in split {
                    if (r == "\"total_count\"") {
                        like = true
                    }
                    if (r == "\"created_time\"") {
                        time = true
                    }
                    if time {
                        rTime = r + ""
                        time = !time
                    }
                    if like {
                        rLike = r + ""
                        like = !like
                    }
                    
                    // Parse date to convert to a time interval since a set point
                    var index = rTime.index(rTime.endIndex, offsetBy: -11)
                    let sub = rTime[index...]
                    let sTime = sub + ""
                    
                    index = sTime.index(sTime.startIndex, offsetBy: 3)
                    let mSubHour = sTime[..<index]
                    let sHour = mSubHour + ""
                    
                    index = sTime.index(sTime.endIndex, offsetBy: -3)
                    let mSubMin = sTime[index...]
                    let sMin = mSubMin + ""
                    let timeElapsed = Int(sHour)! * 360 + Int(sMin)! * 60
                    
                    // Append new Post object
                    self.aFbPosts.append(Post(likes: Int(rLike)!, date: Date(timeIntervalSinceReferenceDate: TimeInterval(timeElapsed)) ))
                }
                
                // Run a model on all found posts - Regression will set display value
                let model = Regression(posts: self.aFbPosts, type: 1)
                model.runAlg()
                
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
        }
        connection.start()
        
    }
    
    
}
/** End of Accounts Class */


/** Extension : Getters and Setters */
extension Accounts {
    /** Get all posts made through instagram */
    public func getInstagramHist() -> [Post] {
        return self.aInstaPosts
    }
    
    /** Get all posts made through facebook */
    public func getFbHist() -> [Post] {
        return self.aFbPosts
    }
}
