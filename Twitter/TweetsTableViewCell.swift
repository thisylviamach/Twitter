//
//  TweetsTableViewCell.swift
//  Twitter
//
//  Created by Sylvia Mach on 3/3/17.
//  Copyright © 2017 Sylvia Mach. All rights reserved.
//

import UIKit
import AFNetworking

protocol TweetsTableViewCellDelegate: class {
    func profileImageOnTap(cell: TweetsTableViewCell, user: User)
}

class TweetsTableViewCell: UITableViewCell {
    
  
    weak var delegate: TweetsTableViewCellDelegate?
  
    var user: User?
    var retweetCount: Int?
    var favoriteCount: Int?
    
    @IBOutlet weak var retweetMentionStackView: UIStackView!
    @IBOutlet weak var retweetUserNameLabel: UILabel!
    @IBOutlet weak var retweetTimestamp: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var retweetFavoriteCountLabel: UILabel!
    
    //Button outlet
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var dateCreateLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!{
        didSet{
            self.profileImageView.isUserInteractionEnabled = true
            let profileImageTap = UITapGestureRecognizer(target: self, action: #selector(userProfileOnTap(_:)))
            self.profileImageView.addGestureRecognizer(profileImageTap)
        }
    }
    
    var isRetweeted: Bool?{
        didSet{
            if isRetweeted!{
                retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
            }
            else{
                retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState.normal)
            }
        }
    }
    
    var isFavorited: Bool?{
        didSet{
            if isFavorited!{
                favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
            }
            else{
                favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControlState.normal)
            }
        }
    }

    var retweet: Tweet?{
        didSet{
            self.user = retweet?.user
            
            if let profileUrlString = retweet?.user?.profileUrl{
                profileImageView.setImageWith(profileUrlString)
                profileImageView.layer.cornerRadius = 4.0
            }
            
            if let timestamp = tweet?.timestamp{
                dateCreateLabel.text = timestamp as String
            }
            
            if let screenname = retweet?.user?.screenName{
                nickNameLabel.text = "@" + screenname
            }
            
            if let userName = retweet?.user?.name{
                nameLabel.text = userName
            }
            
            if let tweetText = retweet?.text{
                tweetTextLabel.text = tweetText as String
            }
            
            if let retweetCount = retweet?.retweetCount {
                retweetCountLabel.text = "\(retweetCount)"
                self.retweetCount = retweetCount
            }
            
            if let favoriteCount = retweet?.favoritesCount {
                retweetFavoriteCountLabel.text = "\(favoriteCount)"
                self.favoriteCount = favoriteCount
            }
            
            if let retweetUserName = tweet?.user?.name{
                retweetUserNameLabel.text = retweetUserName + " retweeted"
            }
            
            retweetMentionStackView.isHidden = false
            
        }
    }
    
    var tweet: Tweet?{
        didSet{
            self.user = tweet?.user
            retweetMentionStackView.frame.size.height = 0
            
            if let tweet = tweet{
                if let retweetStatus = tweet.retweetedStatus{
                    self.retweet = Tweet(dictionary: retweetStatus)
                    return
                }
            }
            
            if let profileUrlString = tweet?.user?.profileUrl {
                profileImageView.setImageWith(profileUrlString)
            }
            
            if let timestamp = tweet?.timestamp{
                dateCreateLabel.text = timestamp as String
            }
            
            if let screenname = tweet?.user?.screenName{
                nickNameLabel.text = "@" + screenname
            }
            
            if let userName = tweet?.user?.name{
                nameLabel.text = userName
            }
            
            if let tweetText = tweet?.text{
                tweetTextLabel.text = tweetText as String
            }
            
            if let retweetCount = tweet?.retweetCount {
                retweetCountLabel.text = "\(retweetCount)"
                self.retweetCount = retweetCount
            }
            
            if let favoriteCount = tweet?.favoritesCount {
                retweetFavoriteCountLabel.text = "\(favoriteCount)"
                self.favoriteCount = favoriteCount
            }
            
            if let retweeted = tweet?.isRetweeted {
                isRetweeted = retweeted
            }
            if let favorite = tweet?.isFavorited {
                isFavorited = favorite
            }
            retweetMentionStackView.isHidden = true
            
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

    @IBAction func retweetBtnOnTap(_ sender: Any) {
    }
   
    @IBAction func favoriteBtnOntap(_ sender: Any) {
    }
    
    func userProfileOnTap(_ gesture: UITapGestureRecognizer){
        if let delegate = delegate{
            var screenName = nickNameLabel.text!
            screenName.remove(at: screenName.startIndex)
            print("Image Clicked: \(screenName)")
            
            delegate.profileImageOnTap(cell: self, user: user!)
            
        }
        
    }

}
