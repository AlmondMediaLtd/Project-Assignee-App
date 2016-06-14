//
//  AppLogic.swift
//  Project-X
//
//  Created by majeed on 14/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation

class App{
    static var Data : AppModel = AppModel()
    static var Memory : AppMemory = AppMemory();
    //static var appDelegate : UIApplication!
    static func StartUp()
    {
        
        App.PrepareCustomUI();
        App.LoadLocalData();
        
        if(App.Data.User.AccessToken != ""){
            App.CreatProjectHub()
        }
        
    }
    
    static func ResetMemory()
    {
        App.Memory.selectedTask = nil;
        App.Memory.selectedActivity = nil;
        App.Memory.selectedTemplate = nil;
    }
    
    static func LoadLocalData()
    {
        let content = X.LoadDataFromDir("App.data")
        App.Data = AppModel(json: content)
    }
    
    static func SaveLocalData()
    {
        //App.Data.SyncTimestamp = NSDate()
        let content = App.Data.toJsonString()
        X.SaveToDataDir("App.data", content: content)
    }
    
    static func SignOut()
    {
        App.Data.User.AccessToken = "";
        App.Data.SyncTimestamp = NSDate()
        App.SaveLocalData()
        
        App.CreatProjectHub()
    }
    
    
    
    
    static func getTemplates()
    {
        
        let filePath = NSBundle.mainBundle().pathForResource("templates", ofType: "json")
        
        // get the contentData
        let contentData = NSFileManager.defaultManager().contentsAtPath(filePath!)
        
        // get the string
        var content = NSString(data: contentData!, encoding: NSUTF8StringEncoding) as? String
        content = content?.stringByReplacingOccurrencesOfString("\n", withString: "")
        content = content?.stringByReplacingOccurrencesOfString("\t", withString: "")
        print(content)
        let templates = TemplateJson(json: content);
        print(templates);
    }
    
    
}