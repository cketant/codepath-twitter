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
    
    class func getTimeline(completion: @escaping ([Tweet]?, Error?) -> Void) -> Void {
        TwitterClient.sharedInstance.get("1.1/statuses/home_timeline.json", parameters: nil, success: { (task: URLSessionDataTask, response: Any) in
            if let response = response as? [NSDictionary]{
                completion(Tweet.tweetsWithArray(dictionaries: response), nil)
            }
            }, failure: {(task: URLSessionDataTask?, error: Error) in
                completion(nil, error)
        })
    }

    static func currentUser(){
        
    }
    
    
}
