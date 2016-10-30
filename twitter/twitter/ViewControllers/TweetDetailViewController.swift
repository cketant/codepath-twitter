//
//  TweetDetailViewController.swift
//  twitter
//
//  Created by christopher ketant on 10/29/16.
//  Copyright © 2016 christopherketant. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
            let calender = Calendar.current
            let date1 = calender.startOfDay(for: createdAtDate)
            let date2 = calender.startOfDay(for: Date())
            let components = calender.dateComponents(Set<Calendar.Component>([.day]), from: date1, to: date2)
            cell.createdAtLabel.text = "\(components.day)"
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
