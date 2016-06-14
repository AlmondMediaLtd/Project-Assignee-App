//
//  PasswordUpdateViewController.swift
//  Evolve Studio
//
//  Created by majeed on 15/01/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import UIKit

class PasswordUpdateViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBOutlet weak var userPasswordTextbox: UITextField!
    @IBOutlet weak var userPasswordRepeatTextbox: UITextField!
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        self.dismissKeyboard();
        
        let password : NSString = "" + userPasswordTextbox.text!
        if(password.length >= 6)
        {
            if(userPasswordTextbox.text == userPasswordRepeatTextbox.text)
            {
                //update password
                SwiftSpinner.show("Updating Password");
                
                let passwordUpdate : UserPasswordUpdate  =  UserPasswordUpdate();
                passwordUpdate.UserAccessToken = App.Data.User.AccessToken;
                passwordUpdate.Password = (password as String)
                
                //App.updatePassword(passwordUpdate);

            }
            else
            {
                App.displayAlert(self, title: "", message: "Passwords do not match")
            }
        }
        else
        {
            App.displayAlert(self, title: "", message: "Passwords must be minimum of 6 characters")
        }
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }


}
