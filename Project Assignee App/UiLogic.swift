//
//  UiLogic.swift
//  Project-X
//
//  Created by majeed on 24/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation
import UIKit

extension App {
    
    static var window : UIWindow = UIWindow()
    
    static func PrepareCustomUI()
    {
        applyLightUI();
    }
    
    static func applyDarkUI()
    {
        window.backgroundColor = UIColor(red: 0.21, green: 0.22, blue: 0.27, alpha: 1.0)//UIColor(patternImage: UIImage(named: "App-BG-Image")!)
        
        window.tintColor = UIColor.whiteColor()
        
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
        //UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0.21, green: 0.22, blue: 0.27, alpha: 0.97)//UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        UINavigationBar.appearance().translucent = true
        let navbarFont = UIFont(name: "Ubuntu", size: 17) ?? UIFont.systemFontOfSize(17)
        let barbuttonFont = UIFont(name: "Ubuntu-Light", size: 15) ?? UIFont.systemFontOfSize(15)
        
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName:UIColor.whiteColor()]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: barbuttonFont, NSForegroundColorAttributeName:UIColor.whiteColor()], forState: UIControlState.Normal)
        
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor(red: 0.21, green: 0.22, blue: 0.27, alpha: 0.97)//UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.03)
        UITabBar.appearance().translucent = true
        
        UIToolbar.appearance().setBackgroundImage(UIImage(), forToolbarPosition: .Any, barMetrics: .Default)
        UIToolbar.appearance().shadowImageForToolbarPosition(.Top)
        UIToolbar.appearance().backgroundColor = UIColor(red: 0.21, green: 0.22, blue: 0.27, alpha: 0.9)//UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.03)
        UIToolbar.appearance().translucent = true
        
        
        UILabel.appearance().textColor = UIColor.whiteColor()
    }
    
    static func applyLightUI()
    {
        window.backgroundColor = UIColor.whiteColor()
        
        window.tintColor = UIColor(red: 0.23, green: 0.49, blue: 1.0, alpha: 1.0)//UIColor(red: 0.21, green: 0.22, blue: 0.27, alpha: 1.0)
        
        let backImg: UIImage = UIImage(named: "ui-icon-back-button")!
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(backImg, forState: .Normal, barMetrics: .Default)
        
        
        //UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
        //UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.93)
        UINavigationBar.appearance().translucent = true
        let navbarFont = UIFont(name: "Helvetica-Light", size: 16) ?? UIFont.systemFontOfSize(16)
        let barbuttonFont = UIFont(name: "Helvetica", size: 15) ?? UIFont.systemFontOfSize(15)
        
        UINavigationBar.appearance().tintColor = UIColor.blackColor()
        
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName:UIColor.darkTextColor()]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: barbuttonFont, NSForegroundColorAttributeName:UIColor.darkTextColor()], forState: UIControlState.Normal)
        
        UITabBar.appearance().backgroundImage = UIImage()
        //UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.93)
        UITabBar.appearance().translucent = true
        
        UIToolbar.appearance().setBackgroundImage(UIImage(), forToolbarPosition: .Any, barMetrics: .Default)
        UIToolbar.appearance().shadowImageForToolbarPosition(.Top)
        UIToolbar.appearance().backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.93)
        UIToolbar.appearance().translucent = true
        
        
        //UILabel.appearance().textColor = UIColor.darkTextColor()
    }

}