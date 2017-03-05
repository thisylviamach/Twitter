//
//  TwitterClient.swift
//  Twitter
//
//  Created by Sylvia Mach on 3/2/17.
//  Copyright © 2017 Sylvia Mach. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let shareInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "45gWhleCpUkGbLY7aWSZo4KDR", consumerSecret: "CdxsgZflAkLr1Qrinkn1KFG9TfUuMW9l7cvP6DhXQqIQWbBbXt")
    
    var loginSuccess: (()->())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping ()->(), failure: @escaping  (Error)->()){
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "mytwitter://oauth"), scope: nil, success: { (responseToken: BDBOAuth1Credential?) -> Void in
            print("I got a token")
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(responseToken!.token!)")!
            UIApplication.shared.open(url)
            
        }, failure: { (error: Error?) -> Void in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
        
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: URL){
        
        let responseToken = BDBOAuth1Credential(queryString: url.query)
     
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: responseToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in
            
            print ("I got the access token")
            
            self.currentAccount(success: { (user: User) -> () in
                User.currentUser = user
                
                self.loginSuccess?()
                
            }, failure: { (error:Error) -> () in
                self.loginFailure?(error)
            })
            
            
            self.loginSuccess?()
            
        }, failure: { (error: Error?)  -> Void in
            print ("Error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
        

    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> () ){
        
        get("1.1/statuses/home_timeline.json",
                    parameters: nil,
                    progress: nil,
                    success: { (task: URLSessionDataTask, response: Any?) -> Void in
                        
                        let dictionary = response as! [NSDictionary]
                        
                        let tweets = Tweet.tweetsWithArray(dictionaries: dictionary)
                        success(tweets) 
                        
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
        

    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> () ){
        get("1.1/account/verify_credentials.json",
                    parameters: nil,
                    progress: nil,
                    success: { (task: URLSessionDataTask?,response: Any?) -> Void in
                        
                        print("Account: \(response)")
                        
                        let userDictionary = response as! NSDictionary
                        let user = User(dictionary: userDictionary)
                        
                        success(user)
                        
        }, failure: { (task: URLSessionDataTask?, error: Error)  -> Void in
            failure(error)
        })
    }
    
    //Returns a collection of the most recent Tweets posted by the user indicated by the screen_name.
    func userTimeline(screenName: String?, success: @escaping ([Tweet]) -> (), falilure: @escaping (Error) -> () ){
        guard let screenName = screenName else {
            print("You pass in an empty screen name")
            return
        }
        
        let param: NSDictionary!
        param = ["screen_name": screenName]
        
        get("1.1/statuses/user_timeline.json", parameters: param, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionary = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionary)
            success(tweets)
        }) { (task: URLSessionDataTask?, error: Error) in
            falilure(error)
        }
        
    }
    
}
