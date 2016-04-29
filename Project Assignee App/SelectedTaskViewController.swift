//
//  SelectedTaskViewController.swift
//  Project Assignee App
//
//  Created by Gladwin Dosunmu on 28/04/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import UIKit

class SelectedTaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var deadline: UILabel!
    
    @IBOutlet weak var budget: UILabel!
    
    var selectedTask: Task = Task()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedTask = App.Memory.selectedTask!
        
        self.title = selectedTask.Title

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedTask.Activities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("activity cell", forIndexPath: indexPath) as! ActivityTableViewCell
        
        let activity = selectedTask.Activities[indexPath.row]
        
        cell.activity = activity
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        App.Memory.selectedActivity = selectedTask.Activities[indexPath.row]
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
