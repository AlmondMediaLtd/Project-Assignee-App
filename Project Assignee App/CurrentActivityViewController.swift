//
//  CurrentActivityViewController.swift
//  Project Assignee App
//
//  Created by Gladwin Dosunmu on 21/04/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import UIKit

class CurrentActivityViewController: UIViewController {
    
    @IBOutlet weak var activityTitle: UILabel!
    
    var titleHolder = ""
    
    @IBOutlet weak var activityDueDate: UILabel!
    
    var dateHolder = ""
    
    @IBOutlet weak var activityCost: UILabel!
    
    var costHolder = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityTitle.text = titleHolder
        activityDueDate.text = dateHolder
        activityCost.text = "\(costHolder)"

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
