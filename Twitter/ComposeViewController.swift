//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Sylvia Mach on 3/5/17.
//  Copyright © 2017 Sylvia Mach. All rights reserved.
//

import UIKit
import AFNetworking

fileprivate let buttonsStackViewOriginY = CGFloat(470)
fileprivate let maxLetter = 140

class ComposeViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var compostTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var initialTextLabel: UILabel!
    
    @IBOutlet weak var letterCountLabel: UILabel!
    @IBOutlet weak var ButtonStackView: UIStackView!
    @IBOutlet weak var TweetButton: UIButton!{
        didSet{
            TweetButton.layer.cornerRadius = 5.0
        }
    }
    
    var user: User?
    var startText: String?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        user = User._currentUser
        
        compostTextView.delegate = self
        compostTextView.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: Notification.Name("UIKeyboardDidShowNotification"), object: nil)
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: Notification.Name("UIKeyboardDidSHideNotification"), object: nil)
        
        updateUserInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tweetBtnOnTap(_ sender: Any) {
        if let status = compostTextView.text{
            TwitterClient.shareInstance?.composeTweet(status: status, success: {
                self.compostTextView.endEditing(true)
                self.performSegue(withIdentifier: "TweetComposedSegue", sender: sender)
                
            })
        }
    }
    
    func keyboardDidShow(notification: Notification){
        if let keyboardRect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            let keyboardHeight = keyboardRect.height
            ButtonStackView.frame.origin.y = buttonsStackViewOriginY - keyboardHeight
        }
    }
    
    func keyboardDidHide(notification: Notification){
        ButtonStackView.frame.origin.y = buttonsStackViewOriginY
    }

    
    func updateUserInfo(){
        if let profileUrlString = user?.profileUrl {
            profileImageView.setImageWith(profileUrlString)
        }
        
        if let screenname = user?.screenName{
            nickNameLabel.text = "@" + screenname
        }
        
        if let userName = user?.name{
            userNameLabel.text = userName
        }
        
        if let startText = startText{
            compostTextView.text = startText + " "
            initialTextLabel.isHidden = true
            updateLetterCount()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if compostTextView.text.characters.count == maxLetter && !text.isEmpty{
            return false
        }
        
        else{
            return true
        }
    }
    
    func updateLetterCount(){
        initialTextLabel.isHidden = !compostTextView.text.isEmpty
        let letterCount = compostTextView.text.characters.count
        letterCountLabel.text = "\(maxLetter - letterCount)"
        if letterCount == maxLetter{
            letterCountLabel.textColor = UIColor.red
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateLetterCount()
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
