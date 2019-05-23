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

struct Inst {
    /** Instagram API const string variables */
    static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/";
    static let INSTAGRAM_CLIENT_ID = "faf836a5070a485e90aa88bed7fe5a54";
    static let INSTAGRAM_CLIENTSECRET = "0785f87adac349f58943cb6234ea4145";
    static let INSTAGRAM_REDIRECT_URI = "https://www.optishareapp.com/instagram";
    static let INSTAGRAM_ACCESS_TOKEN = "access_token";
    static let INSTAGRAM_SCOPE = "follower_list+public_content";
    /** end instagram API strings */
}

class Accounts : UINavigationController {
    
    // Main web view for log in to accounts */
    @IBOutlet weak var loginView: WKWebView!
    
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = WKWebViewConfiguration()
        if (!isLoading) {
            newInstagram()
        }
        print ("Defined acct view");
    }
    
    /** Create a new instagram authorization request */
    /** call to init auth request */
    func newInstagram() {
        let api = Instagram.shared
        isLoading = !isLoading
        
        print("attempting api auth") //TODO del for release
        // Login
        api.login(from: self, success: {
            print ("login successful: ")
            print(api.isAuthenticated)
            self.getMediaInst()

        }, failure: { error in
            print(error.localizedDescription)
        })
        
        // Verify authentication
        getMediaInst()
        print(api.isAuthenticated)
    }
    
    /** likes in recent media */
    func getMediaInst() {
        let api = Instagram.shared
        
        api.recentMedia(fromUser: "self", count: 10, success: { mediaList in
            print("likes: ")
            print(mediaList[0].createdDate)
            print(mediaList[0].likes.count)
            
            print(mediaList[1].createdDate)
            print(mediaList[1].likes.count)
            
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    /** depc. Verify if we received a valid callback url (instagram specific) */
    func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        print(requestURLString)
        if requestURLString.hasPrefix(Inst.INSTAGRAM_REDIRECT_URI) {
            loginView.removeFromSuperview()
            
            let range: Range<String.Index> = requestURLString.range(of: "#/access_token=")!
            
            // Get token (print) TODO rmv
            print("handling auth (ig)")
            print(String(requestURLString[..<range.upperBound]));
            return false;
        }
        return true;
    }
    
    
}
/** End of Accounts Class */

