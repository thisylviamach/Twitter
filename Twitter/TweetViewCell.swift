//
//  TweetViewCell.swift
//  Twitter
//
//  Created by Sylvia Mach on 3/4/17.
//  Copyright © 2017 Sylvia Mach. All rights reserved.
//

import UIKit
import AFNetworking

class TweetViewCell: UITableViewCell {

    @IBOutlet weak var retweetUserNameLabel: UILabel!
    @IBOutlet weak var userNamelabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var dateCreateLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetMentionStackView: UIStackView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var retweet: Tweet?{
        didSet{
            if let profileUrlString = retweet?.user?.profileUrl{
                profileImageView.layer.cornerRadius = 4.0
                profileImageView.clipsToBounds = true
                profileImageView.setImageWith(profileUrlString)
            }
            
            if let userName = retweet?.user?.name{
                userNamelabel.text = userName
            }
            
            if let screenName = retweet?.user?.screenName{
                nickNameLabel.text = "@" + screenName
            }
            
            if let tweetText = retweet?.text{
                tweetTextLabel.text = tweetText as String
                tweetTextLabel.sizeToFit()
            }
            
            if let date_created = retweet?.timestamp{
                dateCreateLabel.text = "\(date_created)"
                dateCreateLabel.sizeToFit()
            }
            
            if let retweetCount = retweet?.retweetCount{
                retweetCountLabel.text = "\(retweetCount)"
            }
            
            if let likeCount = retweet?.favoritesCount{
                favoriteCountLabel.text = "\(likeCount)"
            }

            if let retweetUserName = retweet?.user?.name{
                retweetUserNameLabel.text = retweetUserName + " Retweeted"
            }
            
            retweetMentionStackView.isHidden = false
        }
    }
    
    var tweet: Tweet?{
        didSet{
            retweetMentionStackView.frame.size.height = 0
            if let tweet = tweet{
                if let retweetedStatus = tweet.retweetedStatus{
                    self.retweet = Tweet(dictionary: retweetedStatus)
                    retweetMentionStackView.frame.size.height = 20
                    return
                }
            }
            
            if let profileUrlString = tweet?.user?.profileUrl{
                profileImageView.layer.cornerRadius = 4.0
                profileImageView.clipsToBounds = true
                profileImageView.setImageWith(profileUrlString)
            }
            
            if let userName = tweet?.user?.name{
                userNamelabel.text = userName
            }
            
            if let screenName = tweet?.user?.screenName{
                nickNameLabel.text = "@" + screenName
            }
            
            if let tweetText = tweet?.text{
                tweetTextLabel.text = tweetText as String
                tweetTextLabel.sizeToFit()
            }
            
            if let date_created = tweet?.timestamp{
                dateCreateLabel.text = "\(date_created)"
                dateCreateLabel.sizeToFit()
            }
            
            if let retweetCount = tweet?.retweetCount{
                retweetCountLabel.text = "\(retweetCount)"
            }
            
            if let likeCount = tweet?.favoritesCount{
                favoriteCountLabel.text = "\(likeCount)"
            }
            
            if let retweetUserName = tweet?.user?.name{
                retweetUserNameLabel.text = retweetUserName + " Retweeted"
            }
            
            retweetMentionStackView.isHidden = false

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
