 //
//  TweetsViewController.swift
//  Twitter
//
//  Created by Sylvia Mach on 3/2/17.
//  Copyright © 2017 Sylvia Mach. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var tableView: UITableView!
    
    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        
        
        TwitterClient.shareInstance?.homeTimeline(success: { (tweets) in
            self.tweets = tweets
            self.tableView.reloadData()
            
            
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterClient.shareInstance?.logout()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let tweets = self.tweets{
            return tweets.count
        }
        else{
            return 0
        }
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tweetTableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetsTableViewCell
//        
//        let tweet = tweets![indexPath.row]
//        cell.tweet = tweet
//        cell.selectionStyle = UITableViewCellSelectionStyle.none
//        //cell.delegate = self
//        cell.delegate = self
//        return cell
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetsTableViewCell
        
        let tweet = tweets![indexPath.row]
        cell.tweet = tweet
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.delegate = self
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            if identifier == "ShowTweetDetail"{
//                let tweetDetailVC = segue.destination as! TweetDetailViewController
//                let cell = sender as! TweetsTableViewCell
//                let selectedIndexPath = tweetTableView.indexPath(for: cell)
//                let selectedTweet = tweets![selectedIndexPath!.row]
//                
//                //tweetDetailVC.detailView
//                tweetDetailVC.tweet = selectedTweet
//                
//                let backItem = UIBarButtonItem()
//                backItem.title = "Home"
//                navigationItem.backBarButtonItem = backItem
//                //tweetTableView.deselectRow(at: selectedIndexPath!, animated: true)
                
                
                let tweetDetailVC = segue.destination as! TweetDetailViewController
                
                let cell = sender as! TweetsTableViewCell
                let selectedindexPath = tableView.indexPath(for: cell)
                
                let selectedTweet = tweets![selectedindexPath!.row]
                tweetDetailVC.tweet = selectedTweet
                
                let backItem = UIBarButtonItem()
                backItem.title = "Home"
                navigationItem.backBarButtonItem = backItem
                

            }
        }
    }
 }
 
 
// extension TweetsViewController: TweetsTableViewCellDelegate{
//    func profileImageViewTapped(cell: TweetsTableViewCell, user: User) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileTableViewController{
//            //set the profile user before your push
//            //print(user.name)
//            profileVC.user = user
//            self.navigationController?.pushViewController(profileVC, animated: true)
//        }
//    }
// }
 
extension TweetsViewController: TweetsTableViewCellDelegate{
    func profileImageOnTap(cell: TweetsTableViewCell, user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let profileVC = storyboard.instantiateViewController(withIdentifier:"ProfileViewController") as? ProfileViewController{
            profileVC.user = user
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
 }
