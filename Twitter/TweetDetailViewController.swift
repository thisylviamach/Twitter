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
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        if let profileUrlString = tweet?.user?.profileUrl{
            //set image nicer with rounder corner (From Yelp app)
            profileImageView.layer.cornerRadius = 4.0
            profileImageView.clipsToBounds = true
            profileImageView.setImageWith(profileUrlString)
        }
        
        if let userName = tweet?.user?.name{
            userNameLabel.text = userName
        }
        
        if let screenName = tweet?.user?.screenName{
            nickNameLabel.text = "@" + screenName
        }
        
        if let tweetText = tweet?.text{
            print(tweetText)
            tweetTextLabel.text = tweetText as String
            tweetTextLabel.sizeToFit()
        }
        
        if let date_created = tweet?.timestamp{
            timestampLabel.text = "\(date_created)"
            timestampLabel.sizeToFit()
        }
        
        if let retweetCount = tweet?.retweetCount{
            retweetCountLabel.text = "\(retweetCount)"
        }
        
        if let likeCount = tweet?.favoritesCount{
            likeCountLabel.text = "\(likeCount)"
        }
        
        //self.tableView.reloadData()
//        let tapOnThumbImageRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnThumbImage(tapGestureRecognizer:)))
//        thumbImageView.isUserInteractionEnabled = true
//        thumbImageView.addGestureRecognizer(tapOnThumbImageRecognizer)
        
        let profileImageRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageOntap(sender:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(profileImageRecognizer)
    }
    
    func profileImageOntap(sender: UITapGestureRecognizer){
        performSegue(withIdentifier: "DetailViewToProfileSegue", sender: sender)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 5
        
    }
    
  
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = Bundle.main.loadNibNamed("TweetViewCell", owner: self, options: nil)?.first as! TweetViewCell
        
        cell.retweetMentionStackView.isHidden = true
        
        return cell
    
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
