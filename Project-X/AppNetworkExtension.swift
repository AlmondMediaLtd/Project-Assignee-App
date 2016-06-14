//
//  AppNetwork.swift
//  Project-X
//
//  Created by majeed on 20/05/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation

extension App {
    
    // 
    static var projectHub: Hub!
    static var projectConnection: SignalR!

    
    static var accountHub: Hub!
    static var accontConnection: SignalR!
    
    private static var baseApiUrl : String = "http://projectxplatform.azurewebsites.net";
    
    static var registrationAccount : UserAccount?
    static func registerAccount(account : UserAccount)
    {
        registrationAccount = account;
        accontConnection = SwiftR.connect(baseApiUrl){ connection in
            
            accountHub = connection.createHubProxy("accountHub")
            
            accontConnection.starting = {
            }
            
            accontConnection.reconnecting = {
            }
            
            accontConnection.connected = {
                
                if(registrationAccount != nil ){
                    accountHub.invoke("register", arguments: [registrationAccount!.toJsonString()]) { (result, error) in
                        if(error == nil && result != nil){
                            let feedback = AccountAccessFeedback(dictionary: (result as! [String : AnyObject]))
                            let appUser = feedback.User;
                            if(appUser != nil){
                                App.Data.User = appUser!;
                                print(App.Data.User.AccessToken);
                                registrationAccount = nil
                                accontConnection.stop()
                                CreatProjectHub()
                                App.UserSignupEvent.raise();
                            }
                            else{
                                App.UserSignupFailedEvent.raise(feedback.Message);
                            }
                        }
                        else{
                            App.UserSignupFailedEvent.raise("We are unable to register your account at the moment");
                            print(error)
                        }
                    }
                }
                else{
                    CreatProjectHub()
                }
            }
            
            accontConnection.reconnected = {
            }
            
            accontConnection.disconnected = {
                if(registrationAccount != nil){
                accontConnection.start()
                }
            }
        };
        
        
    }

    
    
    static func loginToAccount(email : String, password : String)
    {
        accontConnection = SwiftR.connect(baseApiUrl){ connection in
            
            accountHub = connection.createHubProxy("accountHub")
            
            accontConnection.starting = {
            }
            
            accontConnection.reconnecting = {
            }
            
            accontConnection.connected = {
                let token = App.Data.User.AccessToken
                if(token == "" ){
                    accountHub.invoke("login", arguments: [email, password]) { (result, error) in
                        if(error == nil && result != nil){
                            let feedback = AccountAccessFeedback(dictionary: (result as! [String : AnyObject]))
                            let appUser = feedback.User;
                            if(appUser != nil){
                                App.Data.User = appUser!;
                                print(App.Data.User.AccessToken);
                                CreatProjectHub()
                                App.UserLoggedInEvent.raise();
                            }
                        }
                        else{
                            App.UserLogInFailedEvent.raise();
                            print(error)
                        }
                    }
                }
                else{
                    CreatProjectHub()
                }
            }
            
            accontConnection.reconnected = {
                let token = App.Data.User.AccessToken
                if(token == "" ){
                    accountHub.invoke("login", arguments: [email, password]) { (result, error) in
                        if(error == nil && result != nil){
                            let feedback = AccountAccessFeedback(dictionary: (result as! [String : AnyObject]))
                            let appUser = feedback.User;
                            if(appUser != nil){
                                App.Data.User = appUser!;
                                print(App.Data.User.AccessToken);
                                CreatProjectHub()
                                App.UserLoggedInEvent.raise();
                            }
                        }
                        else{
                            App.UserLogInFailedEvent.raise();
                            print(error)
                        }
                    }
                }
            }
            
            accontConnection.disconnected = {
                
                accontConnection.start()
            }
        };
        
        
    }
    
    static func CreatProjectHub()
    {
        projectConnection = SwiftR.connect(baseApiUrl){ connection in
            connection.queryString = ["token" : App.Data.User.AccessToken];
            
            projectHub = connection.createHubProxy("projectHub")
            
            projectHub.on("userFound", callback: { args in
                print("Found " + args![0].description);
                if(args![0].description == "-"){
                    App.SignOut()
                    projectHub = nil;
                    projectConnection = nil
                }
            })
            
            projectHub.on("activityUpdated", callback: { args in
                let activity = Activity(dictionary: args![0] as! [String : AnyObject])
                
                App.onActivityUpdated(activity)
            })
            
            projectHub.on("activityDeleted", callback: { args in
                let index =  args![0] as! Int
                App.onActivityDeleted(index)
            })
            
            projectHub.on("taskUpdated", callback: { args in
                let task = Task(dictionary: args![0] as! [String : AnyObject])
                App.displayNotification("The task \(task.Title) was updated")
                App.onTaskUpdated(task)
            })
            
            projectHub.on("taskAssigned", callback: { args in
                let task = Task(dictionary: args![0] as! [String : AnyObject])
                App.displayNotification("The task \(task.Title) was assigned")
                App.getTasks();
            })
            
            projectHub.on("taskUnassigned", callback: { args in
                let task = Task(dictionary: args![0] as! [String : AnyObject])
                App.displayNotification("The task \(task.Title) was revoked")
                App.getTasks();
            })
            
            projectHub.on("tasksSynced", callback: { args in
                App.onTasksSynced(args![0])
            })
            
            
            projectConnection.starting = {
                print("starting")
            }
            
            projectConnection.reconnecting = {
                print("reconnecting")
            }
            
            projectConnection.connected = {
                print("connected")
                let token = App.Data.User.AccessToken
                if(token != "" ){
                    getTasks()
                }
                else{
                    projectConnection.stop()
                }
            }
            
            projectConnection.reconnected = {
                print("reconnected")
            }
            
            projectConnection.disconnected = {
                print("disconnected")
                if(App.Data.User.AccessToken != ""){
                    projectConnection.start()
                }
            }
        }
    }
    
    
    static func getTasks()
    {
        projectHub?.invoke("getAssignedTasks", arguments: []) { (result, error) in
            if(error == nil){
                let response = AssignedTasksResults(dictionary: (result as! [String : AnyObject]))
                
                if( response.Success && App.Data.User.AccessToken != "" ){
                    App.Data.Tasks = response.Tasks;
                    App.Data.SyncTimestamp = response.SycnTimestamp.addHours(1)
                    App.SaveLocalData()
                    TasksReloadedEvent.raise()
                    CurrentTaskChangedEvent.raise()
                }
                print(response.Message)
            }
            else{
                print(error);
            }
            
        };
        
    }
    
    static func onTasksSynced(result : AnyObject){
        let response = AssignedTasksResults(dictionary: (result as! [String : AnyObject]))
        if( response.Success && App.Data.User.AccessToken != "" ){
            App.Data.Tasks = response.Tasks;
            App.Data.SyncTimestamp = response.SycnTimestamp.addHours(1)
            App.SaveLocalData()
            TasksReloadedEvent.raise()
            //AGPushNoteView.showWithNotificationMessage("Projects Synchronised");
        }
        print(response.Message)
    }
    
    static func markTaskAcceptance(task : Task, accepted: Bool)
    {
        projectHub?.invoke("markTaskAcceptance", arguments: [task.Id, accepted]) { (result, error) in
            if(error == nil){
                let response = ActionFeedback(dictionary: (result as! [String : AnyObject]))
                
                if( response.Success ){
                    
                }
                else{
                    print(response.Message)
                }
            }
            else{
                print(error);
            }
            
        };
    }
    
    static func onTaskUpdated(task : Task){
        
            App.getTasks()
    }
    
    static func pushTask(task : Task){
        let index = App.Data.Tasks.indexOf(task)
        if(index >= 0){
            if(task.Id == 0){
                
            }
            else{
                projectHub?.invoke("UpdateTask", arguments: [task.toJsonString(), true]) { (result, error) in
                    if(error == nil){
                        let response = TasksResults(dictionary: (result as! [String : AnyObject]))
                        if(response.Tasks.count > 0){
                            App.Data.Tasks[index!] = response.Tasks[0];
                            //App.Memory.selectedTask = project.Tasks[index!]
                            TasksReloadedEvent.raise()
                            CurrentTaskChangedEvent.raise()
                        }
                        print("-----------")
                        print(response.Message)
                    }
                    else{
                        print("-----------")
                        print(error);
                    }
                };
            }
            
            
        }
        
    }
    
    
    static func onActivityUpdated(activity : Activity){
        let id = activity.Id
        var a : Activity?
        
        for t in App.Data.Tasks {
            
            a =  t.Activities.filter {$0.Id == id}.first
            if(a != nil){
                if let index = t.Activities.indexOf(a!){
                    t.Activities[index] = activity
                    
                    App.SaveLocalData();
                    CurrentActivityChangedEvent.raise()
                    ActivitiesReloadedEvent.raise()
                    TasksReloadedEvent.raise()
                    CurrentTaskChangedEvent.raise()
                    CurrentProjectChangedEvent.raise()
                }
                
            }
        }

        
    }
    
    static func pushActivity(task: Task, activity : Activity){
        let index = task.Activities.indexOf(activity)
        if(index >= 0){
            if(activity.Id == 0){
                projectHub?.invoke("AddActivity", arguments: [task.Id, activity.toJsonString()]) { (result, error) in
                    if(error == nil){
                    }
                    else{
                        print("-----------")
                        print(error);
                    }
                }
            }
            else{
                projectHub?.invoke("UpdateActivity", arguments: [activity.toJsonString()]) { (result, error) in
                    if(error == nil){
                    }
                };
            }
            
            
        }
        
    }

    static func deleteActivity(activity : Activity)
    {
        projectHub?.invoke("DeleteActivity", arguments: [activity.Id]) { (result, error) in
            if(error == nil){
            }
            else{
                print("-----------")
                print(error);
            }
        }
    }
    
    static func onActivityDeleted(id : Int){
        var a : Activity?
        
        for t in App.Data.Tasks {
            
            a =  t.Activities.filter {$0.Id == id}.first
            if(a != nil){
                if let index = t.Activities.indexOf(a!){
                    t.Activities.removeAtIndex(index)
                    
                    App.SaveLocalData();
                    ActivitiesReloadedEvent.raise()
                    TasksReloadedEvent.raise()
                    CurrentTaskChangedEvent.raise()
                    CurrentProjectChangedEvent.raise()
                }
                
            }
        }
    }
    
    static func postProfileImage(image : UIImage)
    {
        let uploadVar = FileUpload(image: image, height: 100)
        uploadVar.accessToken = App.Data.User.AccessToken
        let actionPath = "/Resource/SaveProfileImage";
        postServerData(actionPath, data: uploadVar) { (result) in
            let json = JSON(data: result!)
            print(json.rawString())
        }
    }
    static func downloadProfileImage()
    {
        let imageName = App.Data.User.ResourceUID;
        let profilePhotoPath = "/Resource/Images/Users/\(imageName).jpg";
        
        getServerData(profilePhotoPath) { (result) in
            
            X.setImage(ImageGroup.Profile, name: imageName, data: result)
            App.ProfileImageDownloadedEvent.raise();
        }
    }
    
    static func downloadPlannersImage(tasks: [Task]){
        for task in tasks{
            if(task.PlannerResourceUID != ""){
                downloadContactImage(task.PlannerResourceUID)
            }
        }
    }
    
    static func downloadContactImage(resourceUID : String)
    {
        let imageName = resourceUID;
        let profilePhotoPath = "/Resource/Images/Users/\(imageName).jpg";
        
        getServerData(profilePhotoPath) { (result) in
            
            X.setImage(ImageGroup.Assignees, name: imageName, data: result)
            App.ContactsImageDownloadedEvent.raise(resourceUID)
        }
    }
    
    
    
    static func getServerData(path : String, completion: (result: NSData?) -> Void)
    {
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: baseApiUrl+path)!) { data, response, error in
            //print(data)
            if(data != nil){
                completion(result: data)
            }
            }.resume()
    }
    
    static func postServerData(path : String, data : EVObject, completion: (result: NSData?) -> Void)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: baseApiUrl+path)!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        
        do {
            
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(data.toDictionary(), options: NSJSONWritingOptions())
            
            NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if(data != nil){
                    completion(result: data)
                }
                
                }.resume()
        } catch _ {
            
        }
        
        
    }

    
    
    
    
    
/*  projectHub.invoke("", arguments: []) { (result, error) in
 
    }
*/
}


class Event<T> {
    
    typealias EventHandler = T -> ()
    
    private var eventHandlers = [EventHandler]()
    
    func addHandler(handler: EventHandler) {
        eventHandlers.append(handler)
    }
    
    func raise(data: T) {
        for handler in eventHandlers {
            handler(data)
        }
    }
}