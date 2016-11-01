//
//  TimelineViewController.swift
//  twitter
//
//  Created by christopher ketant on 10/27/16.
//  Copyright © 2016 christopherketant. All rights reserved.
//

import UIKit
import MBProgressHUD

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, NewComposedTweetDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    private var loadingMoreView: InfiniteScrollActivityView!
    let refreshControl: UIRefreshControl! = UIRefreshControl()
    private var tweets: [Tweet] = []
    private var selectedTweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.loadingActivity.startAnimating()
        User.getTimeline { (tweets: [Tweet]?, error: Error?) in
            if let tweets = tweets{
                self.tweets = tweets
            }
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.loadingActivity.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func signout(){
        let alert = UIAlertController(title: "", message: "Are you sure you want to signout?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .destructive) { (action: UIAlertAction) in
            TwitterClient.sharedInstance.deauthorize()
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let nav = storyboard.instantiateViewController(withIdentifier: "LoginNavigationController") as! UINavigationController
            DispatchQueue.main.async {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = nav
            }

        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action: UIAlertAction) in
            
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - UITableView delegate+datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        let tweet = self.tweets[indexPath.row]
        cell.contentTextLabel.text = tweet.text
        if let createdAtDate = tweet.timestamp  {
            let calender = Calendar.current
            let date1 = calender.startOfDay(for: createdAtDate)
            let date2 = calender.startOfDay(for: Date())
            let components = calender.dateComponents(Set<Calendar.Component>([.month, .day, .hour, .minute, .second]), from: date1, to: date2)
            if components.day! < 1{
                cell.daysAgoLabel.text = "\(components.hour!)h"
            }else if(components.day! > 0){
                cell.daysAgoLabel.text = "\(components.day!)d"
            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        self.selectedTweet = self.tweets[indexPath.row]
        self.performSegue(withIdentifier: "detailTweetSegue", sender: nil)
    }
    
    // MARK: - NewComposedTweetDelegate
    
    func updateCache(tweet: Tweet){
        self.tweets.insert(tweet, at: 0)
        self.tableView.reloadData()
    }
    
    // MARK: - Utils
    
    func loadTweets(){
        let latestTweet = self.tweets.first
        User.getTimeline(count: 20, sinceId: (latestTweet?.stringId)!) { (tweets: [Tweet]?, error: Error?) in
            if let tweets = tweets{
                self.tweets = tweets + self.tweets
                if tweets.count > 0{
                    DispatchQueue.main.async {
                        if self.refreshControl.isRefreshing{
                            self.refreshControl.endRefreshing()
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    fileprivate func setup(){
        // tableview
        self.tableView.estimatedRowHeight = 83
        self.tableView.rowHeight = UITableViewAutomaticDimension
        // loading view
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        self.tableView.addSubview(loadingMoreView!)
        var insets = tableView.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        self.tableView.contentInset = insets
        // pull to refresh
        self.refreshControl.addTarget(self, action: #selector(loadTweets), for: UIControlEvents.valueChanged)
        self.tableView.insertSubview(self.refreshControl, at: 0)
        // initial loading
        self.loadingActivity.hidesWhenStopped = true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailTweetSegue" {
            let vc = segue.destination as! TweetDetailViewController
            vc.tweet = self.selectedTweet
        }else{
            let nav = segue.destination as! UINavigationController
            let vc = nav.viewControllers.first as! ComposeTweetViewController
            vc.newComponsedTweetDelegate = self
        }
        
    }
 

}
