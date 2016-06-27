//
//  New_WS_Function.swift
//  workingSetProject
//
//  Created by Osa on 6/15/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Foundation
import Cocoa
import CoreData

var workingSets = [NSManagedObject]() //Stores instances of entity 'Working-Set'

func addNewMember(nameOfWS: String){
    
    let windowObject = windowManager()
    let path = "/Users/Osa/Desktop/"
    /*
    //
    let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
    
    let managedContext = appDelegate.coreDataObject.managedObjectContext
    /*A managed object is linked to an instance of NSManagedObjectContext.
     The managed object context to which a managed object belongs, monitors
     the managed object for changes.*/
    
    
    //2
    let entity = NSEntityDescription.entityForName("Working_Set", inManagedObjectContext: managedContext)
    /*The entity description includes information about the managed object as
     well as attributes and relationships.*/
    
    
    let workingSet = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
    /*Instances of NSManagedObject represent a record in Core Data's backing sotre. remember, it doesn't
     matter what that backing store looks like. NSMangedObject instance contains the information of a
     row in a database table.*/
    
    //3
    workingSet.setValue(nameOfWS, forKey: "smartFOlder")
    
    
    
    //4
    do {
        try managedContext.save()
        //5
        //workingSets.append(workingSet)
    } catch let error as NSError  {
        print("Could not save \(error), \(error.userInfo)")
    }
    */
    
    
    ///*
     let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
     
     let coreDataObject = appDelegate.coreDataObject
     
    coreDataObject.addEntityObject("Working_Set", nameOfKey: "smartFOlder", nameOfObject: nameOfWS)
     //*/
    
    windowObject.createNewFile(path, nameOfFile: nameOfWS)
    
    /*
    do {
        var deliverablePathString = "/Users/Osa/Desktop/\(nameOfWS)"
        try NSFileManager.defaultManager().createDirectoryAtPath(deliverablePathString, withIntermediateDirectories: true, attributes: nil)
    } catch let error as NSError {
        NSLog("\(error.localizedDescription)")
    } catch {
        print("general error - \(error)")
    }
    */
    
    

}