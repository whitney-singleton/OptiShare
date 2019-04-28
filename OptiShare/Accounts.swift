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

class Accounts : UIViewController, WKUIDelegate {
    
    /** Instagram API const string variables */
    static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/";
    static let INSTAGRAM_CLIENT_ID = "faf836a5070a485e90aa88bed7fe5a54";
    static let INSTAGRAM_CLIENTSERCRET = "YOUR_CLIENT_SECRET";
    static let INSTAGRAM_REDIRECT_URI = "optishareapp.com/Instagram";
    static let INSTAGRAM_ACCESS_TOKEN = "access_token";
    static let INSTAGRAM_SCOPE = "follower_list+public_content";
    /** end instagram API strings */
    
    // Web view
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        print ("Defined web view");
    }

    /** Create a new instagram authorization request */
    /** call to init auth request */
    func newInstagram() {
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [Accounts.INSTAGRAM_AUTHURL, Accounts.INSTAGRAM_CLIENT_ID, Accounts.INSTAGRAM_REDIRECT_URI, Accounts.INSTAGRAM_SCOPE]);
        
        let urlRequest = URLRequest.init(url: URL.init(string: authURL)!);
        
        // TODO remove for release
        print (urlRequest.description);
        
        // Define webView
        let webConfiguration = WKWebViewConfiguration();
        webView = WKWebView(frame: .zero, configuration: webConfiguration);
        webView.uiDelegate = self;
        view = webView;
        
        print ("Defined web view");
        
        webView.load(urlRequest);
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
    /** End instagram request */
    
    
    
}
/** End of Accounts Class */
