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

class Accounts : UIWebView {
    
    /** Instagram API const string variables */
    static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/";
    static let INSTAGRAM_CLIENT_ID = "YOUR_CLIENT_ID";
    static let INSTAGRAM_CLIENTSERCRET = "YOUR_CLIENT_SECRET";
    static let INSTAGRAM_REDIRECT_URI = "ENTER_REDIRECT_URI";
    static let INSTAGRAM_ACCESS_TOKEN = "access_token";
    static let INSTAGRAM_SCOPE = "follower_list+public_content";
    /** end instagram API strings */
    
    @IBOutlet weak var wView: Accounts!
    
    
    /** On instagram auth button touch */
    @IBAction func launchInstagramAuth(_ sender: Any) {
        newInstagram();
    }
    
    
    
    
    
    
    
    
    
    /** Create a new instagram authorization request */
    func newInstagram() {
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [Accounts.INSTAGRAM_AUTHURL, Accounts.INSTAGRAM_CLIENT_ID, Accounts.INSTAGRAM_REDIRECT_URI, Accounts.INSTAGRAM_SCOPE]);
        
        let urlRequest = URLRequest.init(url: URL.init(string: authURL)!);
        wView.loadRequest(urlRequest);
    }
    
    /** Varify if we received a valid callback url (instagram specific) */
    func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.hasPrefix(Accounts.INSTAGRAM_REDIRECT_URI) {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            handleAuth(authToken: requestURLString.substring(from: range.upperBound));
            return false;
        }
        return true;
    }
    
    /* Helper for validation auth token TODO remove for release */
    func handleAuth(authToken: String) {
        print("Instagram authentication token ==", authToken)
    }
    
    
    func webView(_ webView: WKWebView, shouldStartLoadWith request:URLRequest, navigationType: UIWebView.NavigationType) -> Bool{
        return checkRequestForCallbackURL(request: request)
    }
}
/** End of Accounts Class */
