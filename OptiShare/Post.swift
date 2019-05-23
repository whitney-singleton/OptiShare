//
//  Post.swift
//  OptiShare
//
//  Created by Jackson on 5/23/19.
//  Copyright © 2019 Jackson. All rights reserved.
//

import Foundation

class Post {
    
    // Number of likes this post has
    var likes:Int
    
    // The date this was posted
    var date:Date
    
    init (likes:Int, date:Date) {
        self.likes = likes
        self.date = date
    }
    
    func dateToTime() -> String {
        let dateStr = self.date.description
        var time = dateStr.dropFirst(11)
        time = time.dropLast(6)
        let fullTime:String = String(time)
        return fullTime
    }
    
    
}
