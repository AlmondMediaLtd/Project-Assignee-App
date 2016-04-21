//
//  CurrentTaskViewController.swift
//  Project Assignee App
//
//  Created by Gladwin Dosunmu on 21/04/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import UIKit

class CurrentTaskViewController: UIViewController {
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
