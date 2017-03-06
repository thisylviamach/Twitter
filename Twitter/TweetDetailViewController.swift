//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Sylvia Mach on 3/4/17.
//  Copyright © 2017 Sylvia Mach. All rights reserved.
//

import UIKit
import AFNetworking

class TweetDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    
    weak var delegate: TweetsTableViewCellDelegate?
    var tweet: Tweet?
    var retweetCount: Int?
    var favorCount: Int?
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        if let profileUrlString = self.tweet?.user?.profileUrl{
            //set image nicer with rounder corner (From Yelp app)
            profileImageView.layer.cornerRadius = 4.0
            profileImageView.clipsToBounds = true
            profileImageView.setImageWith(profileUrlString)
        }
        
        if let userName = self.tweet?.user?.name{
            userNameLabel.text = userName
        }
        
        if let screenName = self.tweet?.user?.screenName{
            nickNameLabel.text = "@" + screenName
        }
        
        if let tweetText = self.tweet?.text{
            print(tweetText)
            tweetTextLabel.text = tweetText as String
            tweetTextLabel.sizeToFit()
        }
        
        if let date_created = tweet?.createdDate{
            timestampLabel.text = "\(date_created)"
            timestampLabel.sizeToFit()
        }
        
        if let retweetCount = tweet?.retweetCount{
            retweetCountLabel.text = "\(retweetCount)"
            self.retweetCount = retweetCount
        }
        
        if let likeCount = tweet?.favoritesCount{
            likeCountLabel.text = "\(likeCount)"
            self.favorCount = likeCount
        }
        
        if let isRetweeted = tweet?.isRetweeted{
            self.isRetweeted = isRetweeted
        }
        
        if let isFavorited = tweet?.isFavorited{
            self.isFavorited = isFavorited
        }
        
        //self.tableView.reloadData()
//        let tapOnThumbImageRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnThumbImage(tapGestureRecognizer:)))
//        thumbImageView.isUserInteractionEnabled = true
//        thumbImageView.addGestureRecognizer(tapOnThumbImageRecognizer)
        
        let profileImageRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageOntap(tapGestureRecognizer:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(profileImageRecognizer)
    }
    
    func profileImageOntap(tapGestureRecognizer: UITapGestureRecognizer){
        performSegue(withIdentifier: "DetailViewToProfileSegue", sender: tapGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 0
        
    }
    
  
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = Bundle.main.loadNibNamed("TweetViewCell", owner: self, options: nil)?.first as! TweetViewCell
        
        cell.retweetMentionStackView.isHidden = true
        
        return cell
    
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        let iden = segue.identifier
//        if iden == "replyFromDetailViewSegue" {
//            let composeVC = segue.destination as! ComposeViewController
//            composeVC.beginText = screenNameLabel.text
//        }
//        else if iden == "DetailViewToProfileView" {
//            let profileVC = segue.destination as! ProfileTableViewController
//            profileVC.user = tweet?.user
//        }
//    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier
        if identifier == "DetailViewToProfileSegue"{
            let profileVC = segue.destination as! ProfileViewController
            profileVC.user = tweet?.user
        }
    }
    

}
