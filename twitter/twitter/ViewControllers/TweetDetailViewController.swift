//
//  TweetDetailViewController.swift
//  twitter
//
//  Created by christopher ketant on 10/29/16.
//  Copyright © 2016 christopherketant. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetDetailCell", for: indexPath) as! TweetDetailTableViewCell
        cell.nameLabel.text = self.tweet.author?.name
        cell.screenNameLabel.text = self.tweet.author?.screenname
        cell.contentTextLabel.text = self.tweet.text
        if let createdAtDate = tweet.timestamp  {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy, hh:mm a"
            cell.createdAtLabel.text = formatter.string(from: createdAtDate)
        }
        if let user = tweet.author {
            cell.nameLabel.text = user.name
            cell.screenNameLabel.text = "@\(user.screenname!)"
            if let url = user.profileUrl{
                cell.profileImageView.setImageWith(url)
                cell.profileImageView.layer.cornerRadius = 5
                cell.profileImageView.clipsToBounds = true
            }
        }
        return cell
    }

}
