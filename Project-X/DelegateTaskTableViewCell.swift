//
//  DelegateTaskTableViewCell.swift
//  Delegate
//
//  Created by majeed on 13/06/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class DelegateTaskTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        taskAcceptanceSwicth.transform = CGAffineTransformMakeScale(0.7, 0.7)
        countIndicator.transform = CGAffineTransformMakeScale(0.7, 0.7)
        taskAcceptanceSwicth.onTintColor = UIColor.blackColor()
        
        self.ownerImageView.contentMode = .ScaleAspectFill
        App.ContactsImageDownloadedEvent.addHandler { (resourceUID) in
            if(self.task.PlannerResourceUID == resourceUID)
            {
                self.ownerImageView.image = X.getImage(ImageGroup.Assignees, name: self.task.PlannerResourceUID)
            }
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var ownerImageView: CircleImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!

    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskProjectLabel: UILabel!
    @IBOutlet weak var taskDueLabel: UILabel!

    @IBOutlet weak var taskAcceptanceSwicth: UISwitch!
    @IBOutlet weak var countIndicator: SwiftBadge!

    
    
    var task : Task = Task() {
        didSet{
            taskTitleLabel.text = task.Title;
            taskProjectLabel.text = task.ProjectTitle;
            taskDueLabel.text = "Due in \(task.DueDate.timeTill() )";
            
            
            
            if(task.AssigneeDidAccept){
                taskAcceptanceSwicth.hidden = true;
                countIndicator.hidden = false
            }
            else{
                taskAcceptanceSwicth.on = false
                countIndicator.hidden = true
            }
            
            let ab = App.getTaskActivityBoard(task)
            let dueActivities = ab.DueActivities.count + ab.UpcomingActivities.count ;
            
            if(dueActivities > 0){
                countIndicator.text = "\(dueActivities)";
            }
            else{
                countIndicator.text = "";
                countIndicator.hidden = true;
            }
            if(dueActivities == 0){
                statusView.backgroundColor = App.successColor
            }
            else{
                statusView.backgroundColor = App.dangerColor
            }
            
            
            if(task.PlannerResourceUID != ""){
                ownerImageView.image = X.getImage(ImageGroup.Assignees, name: task.PlannerResourceUID)
            }
            else{
                ownerImageView.image = nil;
            }
            if(ownerImageView.image == nil){
                ownerImageView.setImageWithString(task.PlannerName)
            }
            
            ownerNameLabel.text = task.PlannerName.componentsSeparatedByString(" ").first ?? task.PlannerName
            
            
        }
    }
    
    @IBAction func taskAccepted(sender: AnyObject) {
        App.markTaskAcceptance(task, accepted: true);
        task.AssigneeDidAccept = true;
        App.TasksReloadedEvent.raise()
    }
}
