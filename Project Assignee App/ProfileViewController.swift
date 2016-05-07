//
//  ProfileViewController.swift
//  Project Assignee App
//
//  Created by Gladwin Dosunmu on 07/05/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    var currentAssignee: Assignee = App.Data.Assignees[0]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullName.text = currentAssignee.Name
        
        jobTitle.text = currentAssignee.JobTitle
        
        email.text = currentAssignee.ContactEmail
        
        phoneNumber.text = currentAssignee.ContactPhone
        
        

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
