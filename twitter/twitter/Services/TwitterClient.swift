//
//  TwitterClient.swift
//  twitter
//
//  Created by christopher ketant on 10/26/16.
//  Copyright © 2016 christopherketant. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "8sZlg9JrKq7YCnP7erHc6TjyU", consumerSecret: "hiCtOgGZIavRpBWXyPVwXiTKGa6FMDoCgYuQrV1mqhDVFPLUDj")!
    
    static func getLoggedInUser(completion: @escaping (User?, Error?) -> Void) -> Void {
        self.sharedInstance.get("1.1/account/verify_credentials.json", parameters: nil, success: { (task: URLSessionDataTask, response: Any) in
            print("account: \(response)")
            if let response = response as? NSDictionary{
                completion(User(dictionary: response), nil)
            }
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            completion(nil, error)
        })
    }
    
    static func getTimeline(completion: @escaping ([Tweet]?, Error?) -> Void) -> Void {
        self.sharedInstance.get("1.1/statuses/home_timeline.json", parameters: nil, success: { (task: URLSessionDataTask, response: Any) in
            if let response = response as? [NSDictionary]{
                completion(Tweet.tweetsWithArray(dictionaries: response), nil)
            }
        }, failure: {(task: URLSessionDataTask?, error: Error) in
            completion(nil, error)
        })
    }
}
