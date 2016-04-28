//
//  CurrentActivityViewController.swift
//  Project Assignee App
//
//  Created by Gladwin Dosunmu on 21/04/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import UIKit

class CurrentActivityViewController: UIViewController {
    
    var selectedActivity: Activity = Activity()
    
    @IBOutlet weak var activityTitle: UILabel!
    
    @IBOutlet weak var activityDueDate: UILabel!
    
    @IBOutlet weak var activityCost: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedActivity = App.Memory.selectedActivity!
        
        activityTitle.text = selectedActivity.Title
        activityDueDate.text = "\(selectedActivity.EndDate)"
        activityCost.text = "\(selectedActivity.Cost)"

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