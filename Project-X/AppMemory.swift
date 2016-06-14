//
//  AppMemory.swift
//  Project-X
//
//  Created by majeed on 02/04/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation

class AppMemory
{
    var Templates : [ProjectTemplate] = []
    var selectedTemplate : ProjectTemplate? = nil
    
    
    
    var selectedTaskIndex : Int = -1
    var selectedTask : Task? {
        get{
            return App.Data.Tasks[safe: selectedTaskIndex];
        }
        set (newValue)
        {
            if(newValue != nil){
                selectedTaskIndex = App.Data.Tasks.indexOf(newValue!) ?? -1
            }
            else{
                selectedTaskIndex = -1;
            }
            
        }
    }
    
    var selectedActivityIndex : Int = -1
    var selectedActivity : Activity? {
        get{
            return selectedTask?.Activities[safe: selectedActivityIndex];
        }
        set (newValue)
        {
            if(newValue != nil){
                selectedActivityIndex = (selectedTask?.Activities.indexOf(newValue!)) ?? -1
            }
            else{
                selectedActivityIndex = -1;
            }
            
        }
    }
    
    
    
    
    var selectedPaymentIndex : Int = -1
    var selectedPayment : Payment? {
        get{
            return selectedTask?.Payments[safe: selectedPaymentIndex];
        }
        set (newValue)
        {
            if(newValue != nil){
                selectedPaymentIndex = (selectedTask?.Payments.indexOf(newValue!)) ?? -1
            }
            else{
                selectedPaymentIndex = -1;
            }
            
        }
    }
}