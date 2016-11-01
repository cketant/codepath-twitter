//
//  User.swift
//  twitter
//
//  Created by christopher ketant on 10/27/16.
//  Copyright © 2016 christopherketant. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
    
    init(dictionary: NSDictionary) {
        self.name = dictionary["name"] as? String
        self.screenname = dictionary["screen_name"] as? String
        let profileImgUrlStr = dictionary["profile_image_url"] as? String
        if let profileImgUrlStr = profileImgUrlStr{
            self.profileUrl = URL(string: profileImgUrlStr)
        }
        self.tagline = dictionary["description"] as? String
    }
    
    class func getTimeline(count: Int = 20, sinceId: String = "", completion: @escaping ([Tweet]?, Error?) -> Void) -> Void {
        var parameters: [String : AnyObject] = [:]
        parameters["count"] = count as AnyObject?
        if !sinceId.isEmpty {
            parameters["since_id"] = sinceId as AnyObject?
        }
        TwitterClient.sharedInstance.get("1.1/statuses/home_timeline.json", parameters: parameters, success: { (task: URLSessionDataTask, response: Any) in
            if let response = response as? [NSDictionary]{
                let sortedTweets = Tweet.tweetsWithArray(dictionaries: response).sorted(by: {$0.timestamp?.compare($1.timestamp!) == .orderedDescending})
                completion(sortedTweets, nil)
            }
            }, failure: {(task: URLSessionDataTask?, error: Error) in
                completion(nil, error)
        })
    }

    
}
