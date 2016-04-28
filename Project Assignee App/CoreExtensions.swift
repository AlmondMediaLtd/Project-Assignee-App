//
//  CoreExtensions.swift
//  KeepFit
//
//  Created by majeed on 09/02/2016.
//  Copyright © 2016 University of Salford. All rights reserved.
//

import Foundation

extension NSDate {
    var startOfDay: NSDate {
        return NSCalendar.currentCalendar().startOfDayForDate(self)
    }
    
    var endOfDay: NSDate {
        let components = NSDateComponents()
        components.day = 1
        components.second = -1
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startOfDay, options: NSCalendarOptions())!
    }
    
    var endOfYesterday: NSDate {
        let components = NSDateComponents()
        components.day = -1
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: endOfDay, options: NSCalendarOptions())!
    }
    
    var tommorrow: NSDate {
        let components = NSDateComponents()
        components.day = 1
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startOfDay, options: NSCalendarOptions())!
    }
    
    var aWeekAgo: NSDate {
        let components = NSDateComponents()
        components.day = -7
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startOfDay, options: NSCalendarOptions())!
    }
    
    var nextWeek: NSDate {
        let components = NSDateComponents()
        components.day = 7
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startOfDay, options: NSCalendarOptions())!
    }
    
    func addDays(days : Int) -> NSDate
    {
        let components = NSDateComponents()
        components.day = days
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startOfDay, options: NSCalendarOptions())!
    }
}


extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start ..< end)]
    }
}


