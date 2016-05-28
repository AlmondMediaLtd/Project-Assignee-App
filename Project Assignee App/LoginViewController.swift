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
    
    let fbLoginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["public_profile", "email", "user_friends"]
        return button
    }()

    @IBAction func loginButton(sender: AnyObject) {
        
        App.Memory.selectedAssignee = App.Data.Assignees[0]
        
        performSegueWithIdentifier("login", sender: self)
        
//        if email.text == "email" && password.text == "password" {
//            
//            App.Memory.selectedAssignee = App.Data.Assignees[0]
//            
//            performSegueWithIdentifier("login", sender: self)
//        } else {
//            
//            UtilityCode.displayAlert("Error", message: "Email or Password is incorrect. Please try again.", viewController: self)
//            
//        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        stackView.addArrangedSubview(fbLoginButton)
        fbLoginButton.delegate = self
        
        if let token = FBSDKAccessToken.currentAccessToken() {
            fetchProfile()
        }
    }
    
    func fetchProfile() {
        print("fetch profile")
        
        let parameters = ["fields": "email, first_name, last_name"]
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            let selectedAssignee = App.Data.Assignees[0]
            
            if let email = result["email"] as? String {
                
                selectedAssignee.ContactEmail = email
                
            }
            
            if let first_name = result["first_name"] as? String {
                
                if let last_name = result["last_name"] as? String {
                    
                    let full_name = first_name + " " + last_name
                    
                    selectedAssignee.Name = full_name
                    
                    App.Memory.selectedAssignee = selectedAssignee
                    
                    let reveal_vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Reveal") as! SWRevealViewController
                    
                    self.presentViewController(reveal_vc, animated: true, completion: nil)
                    
                }
            }
        }
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        fetchProfile()
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
