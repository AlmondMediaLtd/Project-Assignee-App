//
//  TasksTableViewController.swift
//  Project Assignee App
//
//  Created by Gladwin Dosunmu on 21/04/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController {
    
    var tasks = [Task]()
    
    func generateTaks() {
        
        tasks.append(Task(title: "Build the kitchen", dueDate: "20th July 2016", budget: 300.56, assigneeId: "0000", planner: "Mr Joseph"))
        
        tasks.append(Task(title: "Build the bedroom", dueDate: "25th July 2016", budget: 405.26, assigneeId: "0000", planner: "Mr Joseph"))
        
        tasks.append(Task(title: "Build the sitting room", dueDate: "30th July 2016", budget: 1000.92, assigneeId: "0000", planner: "Mr Joseph"))
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateTaks()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("task-cell", forIndexPath: indexPath)

        cell.textLabel?.text = tasks[indexPath.row].title
        
        cell.detailTextLabel?.text = tasks[indexPath.row].dueDate

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "show task" {
            
            if let indexPath = self.tableView?.indexPathForSelectedRow {
                
                print(indexPath)
                
                let currentTaskVc: CurrentTaskViewController = segue.destinationViewController as! CurrentTaskViewController
                
                currentTaskVc.taskTitleHolder = tasks[indexPath.row].title
                
                currentTaskVc.taskDateHolder = tasks[indexPath.row].dueDate
                
                currentTaskVc.taskBudgetHolder = tasks[indexPath.row].budget
                
                currentTaskVc.taskPlannerHolder = tasks[indexPath.row].planner
            }
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
