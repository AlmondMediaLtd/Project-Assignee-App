//
//  AccountViewController.swift
//  Planner
//
//  Created by majeed on 11/06/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        self.navigationItem.hidesBackButton = true;
        
        self.profileImage.contentMode = .ScaleAspectFill
        
        App.downloadProfileImage()
        
        App.ProfileImageDownloadedEvent.addHandler{
            
            self.profileImage.image = X.getImage(ImageGroup.Profile, name: App.Data.User.ResourceUID)
            if(self.profileImage.image == nil){
                self.profileImage.setImageWithString(App.Data.User.Name)
            }
        }
        
        
        App.downloadPlannersImage(App.Data.Tasks)
        
        let user = App.Data.User
        if(user.AccessToken == ""){
            self.navigationController?.popViewControllerAnimated(true)
        }
        else{
            reloadView();
        }
        
        App.TasksReloadedEvent.addHandler {
            self.reloadView()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        App.getTasks()
    }


    @IBOutlet weak var profileImage: CircleImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var tasksAssignedLabel: UILabel!
    @IBOutlet weak var tasksCompletedLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func reloadView()
    {
        let user = App.Data.User
        self.profileImage.image = X.getImage(ImageGroup.Profile, name: user.ResourceUID)
        if(profileImage.image == nil){
            profileImage.setImageWithString(user.Name)
        }
        
        userNameLabel.text = user.Name;
        userEmailLabel.text = user.Email;
        
        tableView.reloadData()
        
    }
    
    
    
    @IBAction func signOut(sender: AnyObject) {
        App.SignOut();
        self.navigationController?.popViewControllerAnimated(true)
    }
   
    @IBAction func pickProfileImage(sender: AnyObject) {
        picker.allowsEditing = true //2
        picker.sourceType = .SavedPhotosAlbum //3
        presentViewController(picker, animated: true, completion: nil)
    }

    @IBAction func closeProfileMenu(sender: AnyObject) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
       
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage //2
        profileImage.contentMode = .ScaleAspectFill //3
        profileImage.image = chosenImage //4
        X.setImage(ImageGroup.Profile, name: App.Data.User.ResourceUID, image: chosenImage)
        App.postProfileImage(chosenImage)
        dismissViewControllerAnimated(true, completion: nil) //5
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    
    //Table view
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return App.Data.Tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DelegateTaskTableViewCell
            let task = App.Data.Tasks[indexPath.row];
            
            cell.task = task;
            
            return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row < App.Data.Tasks.count){
            App.Memory.selectedTask = App.Data.Tasks[indexPath.row];
            self.performSegueWithIdentifier("openTaskSegue", sender: self)
        }
        tableView.selectRowAtIndexPath(nil, animated: true, scrollPosition: UITableViewScrollPosition.Top)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return indexPath.row < App.Data.Tasks.count
    }
    
    
    func tableView(tableView: UITableView, canFocusRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false;
    }
    
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        if(indexPath.row < App.Data.Tasks.count){
            return [UITableViewRowAction(style: .Default, title: "Reject", handler: { (action, indexPath) in
                
                let task = App.Data.Tasks[indexPath.row]
                App.markTaskAcceptance(task, accepted: false);
                 //task.AssigneeLink = ""
                 //task.AssigneeDidAccept = false;
                 //task.Assignee_Id = 0;
                App.Data.Tasks.removeAtIndex(indexPath.row)
                
                App.Memory.selectedTask = nil
                
                App.TasksReloadedEvent.raise()
            })];
        }
        else{
            return nil
        }
        
    }

    
    
    
    
}
