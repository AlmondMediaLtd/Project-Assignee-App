//
//  Model.swift
//  Project Assignee App
//
//  Created by Gladwin Dosunmu on 21/04/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import Foundation

// change date to nsdate

class Task {
    
    var title: String!
    var dueDate: String!
    var budget: Double!
    var assigneeId: String!
    var planner: String!
    var activities: [Activity]
    
    init(title:String, dueDate: String, budget: Double, assigneeId: String, planner: String, activities: [Activity]) {
        
        self.title = title
        self.dueDate = dueDate
        self.budget = budget
        self.assigneeId = assigneeId
        self.planner = planner
        self.activities = activities
    }
    
    //dummy data
    
    class func generateTaks() -> [Task] {
        
        return [
            
            Task(title: "Build the kitchen", dueDate: "20th July 2016", budget: 300.56, assigneeId: "0000", planner: "Mr Joseph", activities: [
                Activity(task: "Build the kicthen", title: "Plumbing", dueDate: "1st July 2016", cost: 90.80),
                Activity(task: "Build the kictehn", title: "Build cupboards", dueDate: "15th July 2016", cost: 80.00)
                ]),
            
            Task(title: "Build the bedroom", dueDate: "25th July 2016", budget: 405.26, assigneeId: "0000", planner: "Mr Joseph", activities: [
                Activity(task: "Build the bedroom", title: "Paint the walls", dueDate: "19th July 2016", cost: 190.80),
                Activity(task: "Build the bedroom", title: "fix the bed", dueDate: "17th July 2016", cost: 60.00)
                ]),
            
            Task(title: "Build the sitting room", dueDate: "30th July 2016", budget: 1000.92, assigneeId: "0000", planner: "Mr Joseph", activities: [
                Activity(task: "Build the sitting room", title: "Paint ceiling", dueDate: "29th July 2016", cost: 100.00),
                Activity(task: "Build the sitting room", title: "Fix lighting", dueDate: "22th July 2016", cost: 160.00)
                ])
        ]
        
    }
    
}


class Activity {
    
    var task: String! // change to task class
    var title: String!
    var dueDate: String!
    var cost: Double!
    var isCompleted = false

    
    init(task: String, title:String, dueDate: String, cost: Double) {
        
        self.task = task
        self.title = title
        self.dueDate = dueDate
        self.cost = cost
    }
    
    
    
}