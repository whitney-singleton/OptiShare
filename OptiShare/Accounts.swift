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
        
        
    }
    
    
}
/** End of Accounts Class */


/** Extension : Getters and Setters */
extension Accounts {
    /** Get all posts made through instagram */
    public func getInstagramHist() -> [Post] {
        return self.aInstaPosts
    }
}
