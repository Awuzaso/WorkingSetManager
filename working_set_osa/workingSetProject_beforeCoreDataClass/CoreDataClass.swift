//
//  CoreDataClass.swift
//  workingSetProject
//
//  Created by Osa on 6/22/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa
import CoreData

class dataCore: NSObject, NSApplicationDelegate{
    
    
    func helloWorld() {
        print ("I'm alive.")
    }
    
    
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
   
    
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "TEILab.testCore" in the user's Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask)
        let appSupportURL = urls[urls.count - 1]
        return appSupportURL.URLByAppendingPathComponent("TEILab.workingSetProject")
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("workingSetProject", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.) This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        let fileManager = NSFileManager.defaultManager()
        var failError: NSError? = nil
        var shouldFail = false
        var failureReason = "There was an error creating or loading the application's saved data."
        
        // Make sure the application files directory is there
        do {
            let properties = try self.applicationDocumentsDirectory.resourceValuesForKeys([NSURLIsDirectoryKey])
            if !properties[NSURLIsDirectoryKey]!.boolValue {
                failureReason = "Expected a folder to store application data, found a file \(self.applicationDocumentsDirectory.path)."
                shouldFail = true
            }
        } catch  {
            let nserror = error as NSError
            if nserror.code == NSFileReadNoSuchFileError {
                do {
                    try fileManager.createDirectoryAtPath(self.applicationDocumentsDirectory.path!, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    failError = nserror
                }
            } else {
                failError = nserror
            }
        }
        
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = nil
        if failError == nil {
            coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
            let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("CocoaAppCD.storedata")
            do {
                try coordinator!.addPersistentStoreWithType(NSXMLStoreType, configuration: nil, URL: url, options: nil)
            } catch {
                
                failError = error as NSError
            }
        }
        
        if shouldFail || (failError != nil) {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            if failError != nil {
                dict[NSUnderlyingErrorKey] = failError
            }
            let error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSApplication.sharedApplication().presentError(error)
            abort()
        } else {
            return coordinator!
        }
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving and Undo support
    
    @IBAction func saveAction(sender: AnyObject!) {
        // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
        if !managedObjectContext.commitEditing() {
            NSLog("\(NSStringFromClass(self.dynamicType)) unable to commit editing before saving")
        }
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSApplication.sharedApplication().presentError(nserror)
            }
        }
    }
    
    func windowWillReturnUndoManager(window: NSWindow) -> NSUndoManager? {
        // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
        return managedObjectContext.undoManager
    }
    
    func applicationShouldTerminate(sender: NSApplication) -> NSApplicationTerminateReply {
        // Save changes in the application's managed object context before the application terminates.
        
        if !managedObjectContext.commitEditing() {
            NSLog("\(NSStringFromClass(self.dynamicType)) unable to commit editing to terminate")
            return .TerminateCancel
        }
        
        if !managedObjectContext.hasChanges {
            return .TerminateNow
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            // Customize this code block to include application-specific recovery steps.
            let result = sender.presentError(nserror)
            if (result) {
                return .TerminateCancel
            }
            
            let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButtonWithTitle(quitButton)
            alert.addButtonWithTitle(cancelButton)
            
            let answer = alert.runModal()
            if answer == NSAlertFirstButtonReturn {
                return .TerminateCancel
            }
        }
        // If we got here, it is time to quit.
        return .TerminateNow
    }
}

extension dataCore{
    ////////////////////////////////////////////////////////////
     /*Used to save to the persistent store of the entity,*/
    func saveManagedContext(){
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
   
    ////////////////////////////////////////////////////////////
    /*Used to add to the persistent store of the entity,*/
    func addEntityObject(nameOfEntity: String, nameOfKey: String){
        
        //1
        let specified_entity = NSEntityDescription.entityForName(nameOfEntity, inManagedObjectContext: self.managedObjectContext)
        
        let new_object = NSManagedObject(entity: specified_entity!, insertIntoManagedObjectContext: self.managedObjectContext)
        
        //2
        new_object.setValue(new_object, forKey: nameOfKey)
    
        //3
        self.saveManagedContext()
        
    }
    
    ////////////////////////////////////////////////////////////
    /*Used to edit attributes of a specified object of a specific entity.*/
    func editEntityObject(nameOfEntity: String, nameOfKey: String, editName: String){
        
        
        //1
        var objectCollection = [NSManagedObject]()
        
        //2
        let fetchRequest = NSFetchRequest(entityName: nameOfEntity)
        
        
        //3
        do {
            let results = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            objectCollection = results as! [NSManagedObject]
            
            for people in results{
                print(people.valueForKey(nameOfKey))
                people.setValue(editName, forKey: nameOfKey)
            }
            self.saveManagedContext()
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

        
    }
    
    ////////////////////////////////////////////////////////////
    /*Used to delete specified objects of a specified entity.*/
    func deleteEntityObject(nameOfEntity: String, nameOfKey: String, nameOfObject: String){
        
        
        //1 - Fetching
        let fetchRequest = NSFetchRequest(entityName: nameOfEntity)
        
        
        //2 - Predicate
        let predicate = NSPredicate(format: "%K == %@",nameOfKey,nameOfObject)
        fetchRequest.predicate = predicate
        
        //3 - Execute Fetch Request
        do{
            
            
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            
            for managedObject in result {
                
                self.managedObjectContext.deleteObject(managedObject as! NSManagedObject)
                self.saveManagedContext()
              
            }
        } catch{
            let fetchError = error as NSError
            print(fetchError)
        }
        
        
    }
    
    
   
    
    
    
}