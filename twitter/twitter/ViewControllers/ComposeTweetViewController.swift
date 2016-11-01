//
//  ComposeTweetViewController.swift
//  twitter
//
//  Created by christopher ketant on 10/29/16.
//  Copyright © 2016 christopherketant. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetCharCountBarButton: UIBarButtonItem!
    var status: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Actions
    @IBAction func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(){
        self.view.endEditing(true)
        Tweet.sendTweet(status: self.status!) { (response: NSDictionary?, error: Error?) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    // MARK: - UITableViewDelegate + UITableViewDatasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 236
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "composeTweetCell", for: indexPath) as! ComposeTableViewCell
        return cell
    }
    
    // MARK: - UITextView Delegate
    func textViewDidChange(_ textView: UITextView) {
//        lbl_count.text=[NSString stringWithFormat:@"%i",140-len];
//        let statusLength = textView.text
        self.status = textView.text
    }
    
    // MARK: - Utils
    fileprivate func setup(){
        self.profileImageView.setImageWith(TwitterClient.sharedInstance.currentUser.profileUrl!)
        self.profileImageView.layer.cornerRadius = 5
        self.profileImageView.clipsToBounds = true
        self.nameLabel.text = TwitterClient.sharedInstance.currentUser.name
        self.screenNameLabel.text = TwitterClient.sharedInstance.currentUser.screenname
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
