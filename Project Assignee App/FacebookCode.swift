//
//  FacebookCode.swift
//  Project Assignee App
//
//  Created by Gladwin Dosunmu on 30/05/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import Foundation

class FacebookCode: NSObject {
    
    static func createLoginButton() -> FBSDKLoginButton {
        
        let button = FBSDKLoginButton()
        button.readPermissions = ["public_profile", "email", "user_friends"]
        return button
    }
    
    static func getUserEmail(completionHandler : (userEmail: String) -> Void) {
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email"]).startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error != nil {
                print(error)
                
            } else if let email = result["email"] as? String {
                
                completionHandler(userEmail: email)
            }
            
        }
        
    }
    
    static func getUserName(completionHandler : (firstName: String, lastName: String) -> Void) {
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "first_name, last_name"]).startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error != nil {
                print(error)
                return
                
            }
            
            if let firstName = result["first_name"] as? String {
                
                if let lastName = result["last_name"] as? String {
                    
                    completionHandler(firstName: firstName, lastName: lastName)
                }
            }
            
        }
        
    }
    
    static func getFriendsId(completionHndler : (iDs: [String]) -> Void) {
        
        FBSDKGraphRequest(graphPath: "/me/friends", parameters: ["fields": "summary"]).startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            var friendsIds = [String]()
            
            if let friendObjects = result["data"] as? [NSDictionary] {
                
                for object in friendObjects {
                    
                    friendsIds.append(object["id"] as! String)
                    
                }
                
                completionHndler(iDs: friendsIds)
            }
        }
    }
}


    