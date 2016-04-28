//
//  Model.swift
//  Project-X
//
//  Created by majeed on 11/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation


class AppModel{
    
    var lastId : Int = 0
    var NewId : Int {get {return ++lastId;}}
    var Projects : [Project] = []
    var Templates : [ProjectTemplate] = []
    var Assignees : [Assignee] = []
    var MediaAttachments : [MediaAttachment] = []
    
}

class Project {
    var Id : Int = 0;
    var Title : String  = "";
    var Template : ProjectTemplate = ProjectTemplate()
    var StartDate = NSDate()
    var EndDate = NSDate()
    var MinBudget : NSDecimalNumber = 0.0
    var MaxBudget : NSDecimalNumber = 0.0
    
    var Details = [String: String]();
    
    var ProjectItems : [ProjectItem] = []
    
    
    
    //Completion
    var IsCompleted : Bool{
        
        get{
            return self.ProjectItems.filter({ (item) -> Bool in
                return item.IsCompleted == false
            }).isEmpty
        }
    }
    var CompletionDate : NSDate?{
        get{
            if(!self.ProjectItems.isEmpty)
            {
                let sortedDate = self.ProjectItems.sort{$0.EndDate.timeIntervalSince1970 > $1.EndDate.timeIntervalSince1970};
                return sortedDate[0].EndDate
            }
            else {
                return nil;
            }
        }
    }
}

class ProjectItem {
    
    var Id : Int = 0;
    var Title : String  = "";
    var StartDate = NSDate()
    var EndDate = NSDate()
    var MinBudget : NSDecimalNumber = 0.0
    var MaxBudget : NSDecimalNumber = 0.0
    
    var PreceedingItem_Id : Int = 0
    
    var Details = [String: String]();
    
    var Tasks : [Task] = []
    
    
    //Completion
    var IsCompleted : Bool{
        
        get{
            return self.Tasks.filter({ (item) -> Bool in
                return item.IsCompleted == false
            }).isEmpty
        }
    }
    var CompletionDate : NSDate?{
        get{
            if(!self.Tasks.isEmpty)
            {
                let sortedDate = self.Tasks.sort{$0.EndDate.timeIntervalSince1970 > $1.EndDate.timeIntervalSince1970};
                return sortedDate[0].EndDate
            }
            else {
                return nil;
            }
        }
    }
}

class Task {
    
    var Id : Int = 0;
    var Title : String  = "";
    var StartDate = NSDate()
    var EndDate = NSDate()
    var MinBudget : NSDecimalNumber = 0.0
    var MaxBudget : NSDecimalNumber = 0.0
    
    var Assignee_Id : Int = 0
    
    var Details = [String: String]();
    
    var Activities : [Activity] = []
    var Resources : [Resource] = []
    
    
    
    //Completion
    var IsCompleted : Bool{
        
        get{
            return self.Activities.filter({ (item) -> Bool in
                return item.IsCompleted == false
            }).isEmpty
        }
    }
    var CompletionDate : NSDate?{
        get{
            if(!self.Activities.isEmpty)
            {
                let sortedDate = self.Activities.sort{$0.EndDate.timeIntervalSince1970 > $1.EndDate.timeIntervalSince1970};
                return sortedDate[0].EndDate
            }
            else {
                return nil;
            }
        }
    }
    
    
    
}

class Assignee {
    var Id : Int = 0;
    var Name : String  = "";
    var JobTitle : String  = "";
    var ContactEmail : String  = "";
    var ContactPhone : String  = "";
    
    var Details = [String: String]();
}

class Activity {
    var Id : Int = 0;
    var Title : String  = "";
    var StartDate = NSDate()
    var EndDate = NSDate()
    var Cost : NSDecimalNumber = 0.0
    
    var DueInDays : Int {
        get{ return UtilityCode.getDaysBetweenDate(NSDate().addDays(1), endDate: self.EndDate )}
    }
    
    var IsCompleted : Bool = false;
    var CompletionDate : NSDate?;
    
    var DoneByAssignee_Id : Int = 0
    
    var Details = [String: String]();
}

class Resource {
    var Id : Int = 0;
    var Title : String  = "";
    
    var Cost : NSDecimalNumber = 0.0
    var PurchaseDate = NSDate();
    
    var Details = [String: String]();
}


class MediaAttachment {
    var Id : Int = 0;
    var Title : String  = "";
    var UploadDate = NSDate();
    var MediaType : TypeOfMedia = .Photo;
    
    var Tags = [String : Int]() //ClassType and Id
    
}
enum TypeOfMedia {
    case Photo
    case WebLink
    case Audio
    case Video
    case Pdf
    case Others
}


