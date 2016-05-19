//
//  LoginViewController.swift
//  Project Assignee App
//
//  Created by Gladwin Dosunmu on 18/05/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!

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
