//
//  Regression.swift
//  OptiShare
//
//  Created by Jackson on 5/23/19.
//  Copyright © 2019 Jackson. All rights reserved.
//

import Foundation

class Regression {
    // All posts being checked
    var posts:[Post]
    
    // The account type
    var type:Int
    
    init (posts:[Post], type:Int) {
        self.posts = posts
        self.type = type
    }
    
    /** Run through all posts and determine the best time */
    func runAlg() {
        var time = 0.0
        var totalLikes = 0;
        for post in posts {
            print("alg")
            print(timeToInt(post:post))
            time = time + (Double(post.getLikes()) * timeToInt(post:post))
            totalLikes = totalLikes + post.getLikes()
        }
        let estimate = time / Double(totalLikes)
        print("estimated at: ")
        print(estimate)
        idealTime.instagramTime = timeToString(est: estimate)
    }
    
    /** Turn a Double time value into a String (all platforms) */
    func timeToString(est:Double) -> String {
        var time = String(Int(floor(est))) + ":"
        let difference = est - floor(est)
        let mn = Int(difference * 60)
        if (mn < 10) {
            time = time + "0" + String(mn)
        } else {
            time = time + String(mn)
        }
        return time
    }
    
    /** Turn String time values into a Double (conf. only for instagram) */
    func timeToInt(post:Post) -> Double {
        let sHr = post.dateToTime().dropLast(6)
        let sMn = post.dateToTime().dropLast(3).dropFirst(3)
        let hr = Int(sHr)
        let mn = Int(sMn)
        let adjTime = Double(hr!) + Double(mn!) / 60.0
        return adjTime
    }
}
