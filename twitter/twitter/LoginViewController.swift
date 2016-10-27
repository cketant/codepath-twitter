//
//  ViewController.swift
//  twitter
//
//  Created by christopher ketant on 10/25/16.
//  Copyright © 2016 christopherketant. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: UIButton){
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestToken(withPath: "oauth/request_token", method: "POST", callbackURL: NSURL(string: "codepath-twitter-clone://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            print("I got a token")
            let authUrl = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.open(authUrl, completionHandler: { (isComplete: Bool) in

            })
            }, failure: { (error: Error?) in
                print(error!.localizedDescription)
        })
    }


}

