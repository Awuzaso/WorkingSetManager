//
//  Edit_WS_Function.swift
//  workingSetProject
//
//  Created by Osa on 6/15/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Foundation
import Cocoa
import CoreData

func getManagedContext() -> NSManagedObjectContext {
    let appDelegate =
        NSApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    return managedContext
}


func saveFetchRequest(managedContext: NSManagedObjectContext){
    do {
        try managedContext.save()
        
    } catch let error as NSError  {
        print("Could not save \(error), \(error.userInfo)")
    }

}

func editFetchRequest(managedContext: NSManagedObjectContext,nameOfWS: String){
    
    
    var workingSet = [NSManagedObject]()
    
    
    //2
    let fetchRequest = NSFetchRequest(entityName: "Working_Set")
    
    //3
    do {
        let results =
            try managedContext.executeFetchRequest(fetchRequest)
        workingSet = results as! [NSManagedObject]
        for people in results{
            print(people.valueForKey("SmartFOlder"))
            people.setValue(nameOfWS, forKey: "SmartFOlder")
        }
        saveFetchRequest(managedContext)
        
            } catch let error as NSError {
        print("Could not fetch \(error), \(error.userInfo)")
    }
  
    
}

func editWSFunc(nameOfWS: String){
    
    let managedContext = getManagedContext()
    editFetchRequest(managedContext,nameOfWS: nameOfWS)
    
    
    
    
    
}

