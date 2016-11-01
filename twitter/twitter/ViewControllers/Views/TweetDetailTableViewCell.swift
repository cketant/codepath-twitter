//
//  TweetDetailTableViewCell.swift
//  twitter
//
//  Created by christopher ketant on 10/29/16.
//  Copyright © 2016 christopherketant. All rights reserved.
//

import UIKit

class TweetDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var contentTextLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
