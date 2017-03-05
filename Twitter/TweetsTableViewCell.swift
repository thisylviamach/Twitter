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
    func profileImageOnTap(cell: TweetsTableViewCell, user: User )
}

class TweetsTableViewCell: UITableViewCell {
    
    weak var delegate: TweetsTableViewCellDelegate?
    var user: User?
    
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
    
    func userProfileOnTap(_ gesture: UITapGestureRecognizer){
        if let delegate = delegate{
            var screenName = nickNameLabel.text!
            screenName.remove(at: screenName.startIndex)
            delegate.profileImageOnTap(cell: self, user: user!)
        }
    }
    
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
