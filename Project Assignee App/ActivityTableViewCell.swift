//
//  ActivityTableViewCell.swift
//  Project Assignee App
//
//  Created by Gladwin Dosunmu on 29/04/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var activity: Activity = Activity() { didSet {
        
        updateUI()
        
        }}
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dueDays: UILabel!
    @IBOutlet weak var doneImage: UIImageView!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var completionSwitch: UISwitch!
    
    @IBOutlet weak var dueStaticLabel: UILabel!
    @IBOutlet weak var daysStaticLabel: UILabel!
    @IBOutlet weak var statusColorView: UIView!
    
    
    func updateUI() {
        
        title.text = activity.Title
        
        cost.text = "£\(activity.Cost)"
        
        doneImage.hidden = true
        
        completionSwitch.hidden = true
        
        if(activity.DueInDays < 0)
        {
            statusColorView.backgroundColor = UIColor(red: 0.86, green: 0.25, blue: 0.22, alpha: 1.0)
            dueStaticLabel.text = "OVERDUE";
            dueDays.text = (activity.DueInDays * -1).description
            daysStaticLabel.text = activity.DueInDays < -1 ? "DAYS AGO" : "DAY AGO" ;
        }
        else if( activity.DueInDays == 0)
        {
            statusColorView.backgroundColor = UIColor(red: 0.95, green: 0.73, blue: 0.07, alpha: 1.0)
            dueStaticLabel.text = "DUE";
            dueDays.text = "!";
            daysStaticLabel.text = "TODAY";
        }
        else
        {
            statusColorView.backgroundColor = UIColor.whiteColor();
            daysStaticLabel.text = activity.DueInDays > 1 ? "DAYS" : "DAY";
        }

        
        
        if activity.IsCompleted == true {
            
            statusColorView.backgroundColor = UIColor(red: 0.32, green: 0.65, blue: 0.33, alpha: 1.0)
            
            dueDays.hidden = true
            dueStaticLabel.hidden = true
            daysStaticLabel.hidden = true
            doneImage.hidden = false
            
        } else {
            
            dueDays.hidden = false
            dueStaticLabel.hidden = false
            daysStaticLabel.hidden = false
            doneImage.hidden = true
            completionSwitch.hidden = false
            
        }
        
    }
    
    @IBAction func completionSwitchChanged(sender: UISwitch) {
        
        if sender.on == true {
            
            activity.CompletionDate = NSDate()
            activity.IsCompleted = true
            updateUI()
            
        }
        
    }
    

}





