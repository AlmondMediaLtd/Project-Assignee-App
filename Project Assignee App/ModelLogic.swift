//
//  ModelLogic.swift
//  Project-X
//
//  Created by majeed on 20/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation

extension App {
    
    
    
    static func getProjectCosts(project : Project) -> CostBreakdown {
        var activitiesCost : Double = 0;
        var resourcesCost : Double = 0;
        
        for item in project.ProjectItems {
            let costs = App.getProjectItemCosts(item);
            activitiesCost += costs.ActivitiesCost.doubleValue
            resourcesCost += costs.ResourcesCost.doubleValue;
        }
        
        return CostBreakdown(activitiesCost: activitiesCost, resourcesCost: resourcesCost);
    }
    static func getProjectItemCosts(projectItem : ProjectItem) -> CostBreakdown {
        var activitiesCost : Double = 0;
        var resourcesCost : Double = 0;
        
        for item in projectItem.Tasks {
            let costs = App.getTaskCosts(item);
            activitiesCost += costs.ActivitiesCost.doubleValue
            resourcesCost += costs.ResourcesCost.doubleValue;
        }
        
        return CostBreakdown(activitiesCost: activitiesCost, resourcesCost: resourcesCost);
    }
    static func getTaskCosts(task : Task) -> CostBreakdown {
        var activitiesCost : Double = 0;
        for item in task.Activities {
            activitiesCost += item.Cost.doubleValue
        }
        
        var resourcesCost : Double = 0;
        for item in task.Resources {
            resourcesCost += item.Cost.doubleValue
        }
        
        return CostBreakdown(activitiesCost: activitiesCost, resourcesCost: resourcesCost);
    }
    
    static func getTaskAssignee(task : Task) -> Assignee?{
        let assignees = App.Data.Assignees.filter{$0.Id == task.Assignee_Id}
        if(assignees.isEmpty){
            return nil;
        }
        else{
            return assignees[0]
        }
    }
    
}


class CostBreakdown {
    
    init(activitiesCost: Double, resourcesCost: Double)
    {
        ActivitiesCost = NSDecimalNumber(double: activitiesCost);
        ResourcesCost = NSDecimalNumber(double: resourcesCost);
        TotalCost = NSDecimalNumber(double: (activitiesCost + resourcesCost));
    }
    var TotalCost: NSDecimalNumber
    var ActivitiesCost: NSDecimalNumber
    var ResourcesCost: NSDecimalNumber
    
}
