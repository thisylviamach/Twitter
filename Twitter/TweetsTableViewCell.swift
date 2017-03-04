//
//  TweetsTableViewCell.swift
//  Twitter
//
//  Created by Sylvia Mach on 3/3/17.
//  Copyright © 2017 Sylvia Mach. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var dateCreateLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var tweet: Tweet!{
        didSet{
            if let profileUrlString = tweet.user?.profileUrl {
                profileImageView.setImageWith(profileUrlString)
            }
            
            if let timestamp = tweet.timestamp{
                dateCreateLabel.text = timestamp as String
            }
            
            if let screenname = tweet.user?.screenName{
                nickNameLabel.text = "@" + screenname
            }
            
            if let userName = tweet.user?.name{
                nameLabel.text = userName
            }
            
            if let tweetText = tweet.text{
                tweetTextLabel.text = tweetText as String
            }
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
