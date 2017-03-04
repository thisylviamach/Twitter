 //
//  Tweet.swift
//  Twitter
//
//  Created by Sylvia Mach on 2/28/17.
//  Copyright © 2017 Sylvia Mach. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: NSString?
    var timestamp: NSString?
    var retweetCount: Int =  0
    var favoritesCount: Int = 0
    var user: User?
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        text = dictionary["text"] as? NSString
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        let formatter = DateFormatter()
        formatter.dateFormat =  "EEE MMM d HH:mm:ss Z y"
        let date_create = formatter.date(from: timestampString!) as NSDate?
        
        let elapsed = Int(Date().timeIntervalSince(date_create! as Date))
    
        if elapsed < 60 * 60 {
            let minutes = (elapsed/60) % 60
            timestamp = "\(minutes)m" as NSString?
        }
        else if elapsed < 60 * 60 * 24 {
            let hours = (elapsed/(60 * 60)) % 24
            timestamp = "\(hours)h" as NSString?
        }
        else if elapsed < 60 * 60 * 24 * 15 {
            let days = (elapsed/(60 * 60 * 24)) % 15
            timestamp = "\(days)d" as NSString?
        }
        else {
            formatter.dateFormat = "MM-dd-yyyy"
            timestamp =  formatter.string(from: date_create! as Date) as NSString?
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}
