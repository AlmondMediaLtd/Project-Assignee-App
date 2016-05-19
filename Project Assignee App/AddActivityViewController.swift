//
//  AddActivityViewController.swift
//  Project Assignee App
//
//  Created by Gladwin Dosunmu on 21/04/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var activityTitle: UITextField!

    @IBOutlet weak var activityCost: UITextField!
    
    let selectedTask = App.Memory.selectedTask
    
    @IBOutlet weak var activityDueDate: UITextField!
    
    
    
    // Date setup
    
    var dateFinal = NSDate()
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .Date
        
        datePicker.date = dateFinal
        
        activityDueDate.inputView = datePicker
        
        datePicker.addTarget(self, action: "datePickerChanged:", forControlEvents: .ValueChanged)
    }
    
    func datePickerChanged(sender: UIDatePicker) {
        
        dateFinal = sender.date
        
        activityDueDate.text = UtilityCode.getDateString(dateFinal)
        
    }
    
    func donePicker() {
        
        self.view.endEditing(true)
    }
    
    @IBAction func addActivity(sender: UIButton) {
        
        if activityTitle.text != "" && activityDueDate.text != "" && activityCost.text != "" {
            
            let newActivity = Activity()
            
            newActivity.Title = activityTitle.text!
            newActivity.EndDate = dateFinal
            newActivity.Cost = NSDecimalNumber(string: activityCost.text!)
            
            selectedTask?.Activities.append(newActivity)
            
            self.navigationController?.popViewControllerAnimated(true)
            
            
        } else {
            UtilityCode.displayAlert("Error", message: "Please fill in all the fields.", viewController: self)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.activityDueDate.delegate = self
        
        activityDueDate.text = UtilityCode.getDateString(dateFinal)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        activityDueDate.inputAccessoryView = toolBar
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(TextField: UITextField) -> Bool {
        
        TextField.resignFirstResponder()
        
        return true
        
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
