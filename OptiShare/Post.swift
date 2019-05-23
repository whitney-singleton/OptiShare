//
//  Post.swift
//  OptiShare
//
//  Created by Jackson on 5/23/19.
//  Copyright © 2019 Jackson. All rights reserved.
//

import Foundation


/** The main time values that this program tries to calculate */
struct idealTime {
    
    static var instagramTime:String = "0:00"
    
    static var facebookTime:String = "0:00"
    
    static var linkedinTime:String = "0:00"
    
    static var combinedTime:String = "0:00"
    
}

/** A Post object represents a single Post across any platform */
class Post {
    
    // Number of likes this post has
    var likes:Int
    
    // The date this was posted
    var date:Date
    
    init (likes:Int, date:Date) {
        self.likes = likes
        self.date = date
    }
    
    /** Convert an (insta confirmed only) account to string from Date object */
    func dateToTime() -> String {
        let dateStr = self.date.description
        var time = dateStr.dropFirst(11)
        time = time.dropLast(6)
        let fullTime:String = String(time)
        return fullTime
    }
    
    /** Get like count for this post */
    func getLikes() -> Int {
        return self.likes
    }
    
    
}
