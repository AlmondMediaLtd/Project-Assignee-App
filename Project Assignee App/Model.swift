//
//  Model.swift
//  Project Assignee App
//
//  Created by Gladwin Dosunmu on 21/04/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import Foundation

class Task {
    
    var title: String!
    var dueDate: String!
    var budget: Double!
    var assigneeId: String!
    var planner: String!
    
    init(title:String, dueDate: String, budget: Double, assigneeId: String, planner: String) {
        
        self.title = title
        self.dueDate = dueDate
        self.budget = budget
        self.assigneeId = assigneeId
        self.planner = planner
    }

}