//
//  LoginViewController.swift
//  Project Assignee App
//
//  Created by Gladwin Dosunmu on 18/05/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    let fbLoginButton: FBSDKLoginButton = FacebookCode.createLoginButton()

    @IBAction func loginButton(sender: AnyObject) {
        
        App.Memory.selectedAssignee = App.Data.Assignees[0]
        
        performSegueWithIdentifier("login", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        stackView.addArrangedSubview(fbLoginButton)
        fbLoginButton.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if FBSDKAccessToken.currentAccessToken() != nil {
            fetchProfile()
            
        }
    }
    
    func fetchProfile() {
        print("fetch profile")
        
        let selectedAssignee = App.Data.Assignees[0]
        
        FacebookCode.getUserEmail { (userEmail) -> Void in
            
            selectedAssignee.ContactEmail = userEmail
            
        }
        
        FacebookCode.getUserName { (firstName, lastName) -> Void in
            
            selectedAssignee.Name = firstName + " " + lastName
        }        
        
        App.Memory.selectedAssignee = selectedAssignee
        
        let reveal_vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Reveal") as! SWRevealViewController
        
        self.presentViewController(reveal_vc, animated: true, completion: nil)
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {

    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
