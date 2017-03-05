//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Sylvia Mach on 3/5/17.
//  Copyright © 2017 Sylvia Mach. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tweets: [Tweet]!
    var user: User?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        TwitterClient.shareInstance?.userTimeline(screenName: user?.screenName, success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }, falilure: { (error:Error) in
            print("Error: \(error.localizedDescription)")
        })
        
        updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let tweets = tweets{
            return tweets.count
        }
        else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = Bundle.main.loadNibNamed("TweetViewCell", owner: self, options: nil)?.first as! TweetViewCell
        
        let tweet = self.tweets[indexPath.row]
        
        cell.tweet = tweet
        return cell
        
    }
    
    func updateUI(){
        if let profileUrlString = user?.profileUrl{
            profileImage.setImageWith(profileUrlString)
            profileImage.layer.cornerRadius = 4.0
        }
        
        if let userName = user?.name{
            userNameLabel.text = userName
        }
        
        if let screenName = user?.screenName{
            nickNameLabel.text = "@" + screenName
        }
        
        if let tagline = user?.tagline{
            userDescription.text = tagline
            userDescription.sizeToFit()
        }
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
