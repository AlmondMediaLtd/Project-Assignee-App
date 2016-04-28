//
//  DataLogic.swift
//  Project-X
//
//  Created by majeed on 14/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation

extension App {
    
    
    
    static func CreateProject(title: String, date : NSDate, budget: Double, template: ProjectTemplate?) -> Project
    {
        let project = Project()
        project.Id = App.Data.NewId;
        project.Title = title
        project.MaxBudget = NSDecimalNumber(double: budget)
        project.EndDate = date
        
        if(template != nil)
        {
            project.Template = template!;
            project.Details = template!.Details;
            for item in template!.ProjectItemTemplates
            {
                project.ProjectItems.append(App.CreateProjectItem(item.Title, template: item))
            }
        }
        
        return project
    }
    
    static func CreateProjectItem(title: String, template : ProjectItemTemplate?) -> ProjectItem
    {
        let projectItem = ProjectItem()
        projectItem.Id = App.Data.NewId;
        projectItem.Title = title

        
        if(template != nil)
        {
            projectItem.Details = template!.Details;
            for item in template!.TaskTemplates
            {
                //projectItem.Tasks.append(App.CreateTask(item.Title, template: item))
            }
        }
        
        return projectItem;
    }
    
    static func CreateTask(title: String, date : NSDate, budget: Double, template : TaskTemplate?) -> Task
    {
        let task = Task()
        task.Id = App.Data.NewId;
        task.Title = title
        task.MaxBudget = NSDecimalNumber(double: budget)
        task.EndDate = date
        
        if(template != nil)
        {
            task.Details = template!.Details;
            for item in template!.ActivityTemplates
            {
                //task.Activities.append(App.CreateActivity(item.Title, template: item))
            }
            for item in template!.ResourceTemplates
            {
                task.Resources.append(App.CreateResource(item.Title, template: item))
            }
        }
        
        return task;
    }
    
    static func CreateActivity(title: String, date : NSDate, cost: Double, template : ActivityTemplate?) -> Activity
    {
        let activity = Activity()
        activity.Id = App.Data.NewId;
        activity.Title = title
        activity.Cost = NSDecimalNumber(double: cost)
        activity.EndDate = date
        
        
        if(template != nil)
        {
            activity.Details = template!.Details;
        }
        
        return activity;
    }
    
    static func CreateResource(title: String, template : ResourceTemplate?) -> Resource
    {
        
        let resource = Resource()
        resource.Id = App.Data.NewId;
        resource.Title = title
        
        
        if(template != nil)
        {
            resource.Details = template!.Details;
        }
        
        return resource;
    }
    
    
    
}