//
//  UserProfileUpdateViewController.swift
//  Evolve Studio
//
//  Created by majeed on 15/01/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import UIKit

class UserProfileUpdateViewController: UITableViewController , UIImagePickerControllerDelegate,
UINavigationControllerDelegate{

    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self

        self.profileImage.contentMode = .ScaleAspectFill
        
        App.downloadProfileImage()
        
        App.ProfileImageDownloadedEvent.addHandler{
            
            self.profileImage.image = X.getImage(ImageGroup.Profile, name: App.Data.User.ResourceUID)
            if(self.profileImage.image == nil){
                self.profileImage.setImageWithString(App.Data.User.Name)
            }
        }
        
        let user = App.Data.User
        if(user.AccessToken == ""){
            self.navigationController?.popViewControllerAnimated(true)
        }
        else{
            self.profileImage.image = X.getImage(ImageGroup.Profile, name: App.Data.User.ResourceUID)
            if(profileImage.image == nil){
                profileImage.setImageWithString(user.Name)
            }

            let user = App.Data.User;
            userNameTextbox.text = user.Name;
            userEmailTextbox.text = user.Email;
            userProfessionTextbox.text = user.Profession;
            userPhoneTextbox.text = user.Phone;
        }
       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.dismissKeyboard();
    }

    @IBOutlet weak var profileImage: CircleImageView!
    @IBOutlet weak var userNameTextbox: UITextField!
    @IBOutlet weak var userEmailTextbox: UITextField!
    @IBOutlet weak var userProfessionTextbox: UITextField!
    @IBOutlet weak var userPhoneTextbox: UITextField!
    
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        self.dismissKeyboard();
        SwiftSpinner.show("Updating Profile");
        
        let profileUpdate = AppUser();
        profileUpdate.AccessToken = App.Data.User.AccessToken;
        profileUpdate.Name =  userNameTextbox.text!
        profileUpdate.Phone = userPhoneTextbox.text!
        profileUpdate.Profession  = userProfessionTextbox.text!
        
        //App.pushUserDetails(profileUpdate);
        
    }

    
    @IBAction func surfaceTapped(sender: AnyObject) {
        self.dismissKeyboard();
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func pickProfileImage(sender: AnyObject) {
        picker.allowsEditing = true //2
        picker.sourceType = .SavedPhotosAlbum //3
        presentViewController(picker, animated: true, completion: nil)
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

}
