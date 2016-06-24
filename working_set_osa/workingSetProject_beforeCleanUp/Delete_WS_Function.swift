//
//  Delete_WS_Function.swift
//  workingSetProject
//
//  Created by Osa on 6/15/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Foundation
import Cocoa
import CoreData


func DeleteFunc(nameOfWS: String){
    /*
    //1
    //var managedObjectContext: NSManagedObjectContext!
    
    let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
    
    //let managedContext = appDelegate.managedObjectContext.coreDataObject.managedObjectContext
    let managedContext = appDelegate.coreDataObject.managedObjectContext
    let name = nameOfWS
    
    //2 - Fetching
    let fetchRequest = NSFetchRequest(entityName: "Working_Set")
    
    
    //3 - Predicate
    let predicate = NSPredicate(format: "%K == %@","smartFOlder","\(name)")
    fetchRequest.predicate = predicate
    
    //4 - Execture Fetch Request
    do{
        
        
        let result = try managedContext.executeFetchRequest(fetchRequest)
        
        for managedObject in result {
            
            managedContext.deleteObject(managedObject as! NSManagedObject)
            //saveFetchRequest(managedContext)

            
        }
    } catch{
        let fetchError = error as NSError
        print(fetchError)
    }
 */
    
    
    let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
    
    let coreDataObject = appDelegate.coreDataObject
    
    coreDataObject.deleteEntityObject("Working_Set", nameOfKey: "smartFOlder", nameOfObject: nameOfWS)

    
    
    
    
    
}