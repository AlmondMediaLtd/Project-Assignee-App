//
//  CurrentTaskViewController.swift
//  Project Assignee App
//
//  Created by Gladwin Dosunmu on 21/04/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import UIKit

class CurrentTaskViewController: UIViewController {
    
    var activities: [Activity] = []
    
    @IBOutlet weak var taskTitle: UILabel!
    
    var taskTitleHolder = ""
    
    @IBOutlet weak var taskDueDate: UILabel!
    
    var taskDateHolder = ""
    
    @IBOutlet weak var taskBudget: UILabel!
    
    var taskBudgetHolder = 0.0

    @IBOutlet weak var taskPlanner: UILabel!
    
    var taskPlannerHolder = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTitle.text = taskTitleHolder
        taskDueDate.text = taskDateHolder
        taskBudget.text = "£\(taskBudgetHolder)"
        taskPlanner.text = taskPlannerHolder

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "view activities" {
            let activityTableVc = segue.destinationViewController as! ActivityTableViewController
            
            activityTableVc.activities = activities
        }
        
    }


}
