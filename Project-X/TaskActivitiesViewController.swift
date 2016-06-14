//
//  TaskActivitiesViewController.swift
//  Project-X
//
//  Created by majeed on 24/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class TaskActivitiesViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var plannerLinkButton: CircleButton!
    //@IBOutlet weak var assigneeNameLabel: UILabel!
    @IBOutlet weak var taskBudgetLabel: UILabel!
    @IBOutlet weak var pendingActivitiesLabel: UILabel!
    @IBOutlet weak var taskDaysLeft: UILabel!
    //@IBOutlet weak var taskActivitiesLeft: UILabel!
    
    @IBOutlet weak var activitiesTableView: UITableView!
    @IBOutlet weak var activitiesView: UIView!
    
//    @IBOutlet weak var paymentsTableView: UITableView!
//    @IBOutlet weak var paymentsView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        App.CurrentTaskChangedEvent.addHandler {self.reloadData()}
        App.ActivitiesReloadedEvent.addHandler {self.reloadData()}
        App.CurrentActivityChangedEvent.addHandler {self.reloadData()}
        
        self.plannerLinkButton.imageView?.contentMode = .ScaleAspectFill
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        App.Memory.selectedActivity = nil;
        task = App.Memory.selectedTask!;
        reloadData();
    }
    
    var task : Task = Task()
    
    func reloadData() {
        task = App.Memory.selectedTask!;
        self.navigationItem.title = " ";
        taskTitleLabel.text = task.Title.uppercaseString
        
        if(task.PlannerResourceUID != ""){
            let image = X.getImage(ImageGroup.Assignees, name: task.PlannerResourceUID)
            self.plannerLinkButton.imageView?.image = image;
            
        }
        
        if(self.plannerLinkButton.imageView?.image == nil){
            self.plannerLinkButton.imageView?.setImageWithString(task.PlannerName)
        }
        
        self.taskBudgetLabel.text = X.formatNumber(task.Budget)
        self.taskDaysLeft.text = X.getDaysBetweenDate(NSDate().endOfYesterday, endDate:  task.DueDate).description
        self.pendingActivitiesLabel.text = task.Activities.filter({ (item) -> Bool in
            return !item.IsCompleted
        }).count.description;
        
        activitiesTableView.reloadData()
    }
    
    
    
    
    @IBAction func addActivityTapped(sender: AnyObject) {
        
    }
    
    
    @IBAction func openPlannerContact(sender: AnyObject) {
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.Activities.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //if(tableView == activitiesTableView){
            if(indexPath.row >= task.Activities.count){
                
                let cell = activitiesTableView.dequeueReusableCellWithIdentifier("addItemCell", forIndexPath: indexPath) as! ActivitiesFooterTableViewCell
                cell.totalCost = App.getTaskCosts(task).TotalCost
                return cell
            }
            else{
                let cell = activitiesTableView.dequeueReusableCellWithIdentifier("activityCell", forIndexPath: indexPath) as! ActivityTableViewCell
                let activity = task.Activities[indexPath.row];
                
                cell.activity = activity;
                
                return cell
            }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row < task.Activities.count){
            App.Memory.selectedActivity = task.Activities[indexPath.row];
            self.performSegueWithIdentifier("editActivitySegue", sender: self)
        }
        tableView.selectRowAtIndexPath(nil, animated: true, scrollPosition: UITableViewScrollPosition.Top)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return indexPath.row < task.Activities.count
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        if(indexPath.row < task.Activities.count){
            App.Memory.selectedActivity = task.Activities[indexPath.row];
            self.performSegueWithIdentifier("editActivitySegue", sender: self);
        }
    }
    
    func tableView(tableView: UITableView, canFocusRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false;
    }
    
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        if(indexPath.row < task.Activities.count){
            return [UITableViewRowAction(style: .Default, title: "Delete", handler: { (action, indexPath) in
                
                App.deleteActivity(self.task.Activities[indexPath.row])
                self.task.Activities.removeAtIndex(indexPath.row)
                App.Memory.selectedActivity = nil
                App.CurrentTaskChangedEvent.raise();
            })];
        }
        else{
            return nil
        }
        
    }

}
