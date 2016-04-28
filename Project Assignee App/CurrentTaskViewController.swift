//
//  CurrentTaskViewController.swift
//  Project Assignee App
//
//  Created by Gladwin Dosunmu on 21/04/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import UIKit

class CurrentTaskViewController: UIViewController {
    
    var selectedTask: Task = Task()
    
    var activities: [Activity] = []
    
    @IBOutlet weak var taskTitle: UILabel!
    
    
    @IBOutlet weak var taskDueDate: UILabel!
    
    
    @IBOutlet weak var taskBudget: UILabel!
    

    @IBOutlet weak var taskPlanner: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedTask = App.Memory.selectedTask!
        
        taskTitle.text = selectedTask.Title
        taskDueDate.text = "\(selectedTask.EndDate)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
