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
            let nserror = error as! NSError
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
                
                failError = error as! NSError
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
   
    
    
    func getDataObjects(nameOfEntity:String) -> Array<NSManagedObject>{
        var dataObjects = [NSManagedObject]()
        
        //2
        let fetchRequest = NSFetchRequest(entityName: nameOfEntity) // Keep, buy will need to specify a string as argument to hold this value.
        
        //3
        do {
            let results =
                try self.managedObjectContext.executeFetchRequest(fetchRequest) // Use a self reference
                dataObjects = results as! [NSManagedObject] //Define earlier
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return dataObjects
    }
    
    ////////////////////////////////////////////////////////////
    /*Used to add new objects to the persistent store of a given entity.*/
    func addEntityObject(nameOfEntity: String, nameOfKey: String, nameOfObject: String){
        
        // 1 - Create an instance of NSEntity Description
            let specified_entity = NSEntityDescription.entityForName(nameOfEntity, inManagedObjectContext: self.managedObjectContext)
        
        // 2 - Create new object for entity description and insert it within the entity.
            let new_object = NSManagedObject(entity: specified_entity!, insertIntoManagedObjectContext: self.managedObjectContext)
        
        // 3 - Set value of new object.
            new_object.setValue(nameOfObject, forKey: nameOfKey)
    
        // 4 - Save the object.
            self.saveManagedContext()
        
        
    }
    
    // - MARK: Functions for single objects represented within a database.
    
    //
    func setSingleObjectAttrib(nameOfEntity:String,nameOfKey:String,value:String){
        //1
        var objectCollection = [NSManagedObject]()
        
        //2
        let fetchRequest = NSFetchRequest(entityName: nameOfEntity)
       
        
        //3
        do{
        
        
        let result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
        
        for managedObject in result {
        
        managedObject.setValue(value, forKey: nameOfKey)
        self.saveManagedContext()
        
        }
        } catch{
        let fetchError = error as NSError
        print(fetchError)
        }
    }
    
    func getSingleObjectAttrib(nameOfEntity:String,nameOfKey:String)->String{
        var retVal:String!
        //1
        var objectCollection = [NSManagedObject]()
        
        //2
        let fetchRequest = NSFetchRequest(entityName: nameOfEntity)
        
        
        //3
        do{
            
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            
            for managedObject in result {
                
                retVal = managedObject.valueForKey(nameOfKey) as! String
                
            }
        } catch{
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return retVal
    }
    
    

    ////////////////////////////////////////////////////////////
    /*Used to edit attributes of a specified object of a specific entity.*/
    func editEntityObject(nameOfEntity: String, nameOfKey: String, oldName:String, editName: String){
        
        
        //1
       
        
        //2
        let fetchRequest = NSFetchRequest(entityName: nameOfEntity)
        let predicate = NSPredicate(format: "%K == %@",nameOfKey,oldName)
        fetchRequest.predicate = predicate
        
        //3
        do{
            
            
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            
            for managedObject in result {
                
                managedObject.setValue(editName, forKey: nameOfKey)
                self.saveManagedContext()
                
            }
        } catch{
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    
    
    func editEntity(result:[AnyObject],newAttrKey:String,newAttr:String){
        // 1 - Loop through array of 'result'.
            for managedObject in result {
                
                // 2 - Set value for 'newAttrKey' with 'newAttr'.
                    managedObject.setValue(newAttr, forKey: newAttrKey)
                // 3 - Save changes to persistent store.
                    self.saveManagedContext()
            }
    }
    
    func new_editEntityObject(nameOfEntity: String, nameOfSearchKey: String, searchAttr:String, newAttrKey:String ,newAttr: String){
        // 1 - Get fetch request
        print("Hello!")
        print("Name of entity is, \(nameOfEntity).")
        print("Name of search key is, \(nameOfSearchKey).")
        print("Name of search attribute is, \(searchAttr)")
            let fetchRequest = get_fetchRequest(nameOfEntity, nameOfKey: nameOfSearchKey, nameOfObject: searchAttr)
        print("Goodbye!")
        // 2 - Get array of NSAnyObject
            let result = get_result(fetchRequest)
        print("Crashed?")
        // 3 - Edit attribute of object.
           // editEntity(result, newAttrKey: newAttrKey, newAttr: newAttr)
        
    }
    
    /*Used to get a fetch request object as per arguments.*/
    func get_fetchRequest(nameOfEntity: String, nameOfKey: String, nameOfObject: String)->NSFetchRequest{
        print("Name of entity is, \(nameOfEntity).")
        print("Name of search key is, \(nameOfKey).")
        print("Name of search attribute is, \(nameOfObject)")
        // 1 - Generate 'fetchRequest' object.
        let fetchRequest = NSFetchRequest(entityName: nameOfEntity)
        
        // 2 - Specify predicate for 'fetchRequest' object.
        let predicate = NSPredicate(format: "%K == %@",nameOfKey,nameOfObject)
        fetchRequest.predicate = predicate
        
        // 3 - Return 'fetchRequest' object.
        return fetchRequest
    }
    
    func setValueOfEntityObject(nameOfEntity: String, nameOfKey: String, oldName:String, editName: String){
        
        
      
        
        //2
        let fetchRequest = NSFetchRequest(entityName: nameOfEntity)
        let predicate = NSPredicate(format: "%K == %@","smartFOlder",oldName)
        fetchRequest.predicate = predicate
        
        //3
        do{
            
            
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            
            for managedObject in result {
                
                print("For \(managedObject.valueForKey("smartFOlder")), it's \(nameOfKey) is set to \(editName)")
                managedObject.setValue(editName, forKey: nameOfKey)
                self.saveManagedContext()
                
            }
        } catch{
            let fetchError = error as NSError
            print(fetchError)
        }
    }
 
    
    /*Used to delete specified objects of a specified entity.*/
    func deleteEntityObject(nameOfEntity: String, nameOfKey: String, nameOfObject: String){
        
        // 1 - Get fetch request
            let fetchRequest = get_fetchRequest(nameOfEntity, nameOfKey: nameOfKey, nameOfObject: nameOfObject)
        
        // 2 = Get array of NSAnyObject
            let result = get_result(fetchRequest)
        
        // 3 - Delete result
            deleteFromEntity(result)
        
    }
    
    
    
    
    
    
    
    /*Used to get resulting array of objects from CoreData  as specified by 'fetchRequest'.*/
    func get_result(fetchRequest:NSFetchRequest)->[AnyObject]{
        // 1 - Generate 'result' array of type, AnyObject.
            var result = [AnyObject]!()
        
        // 2 - Populate array of 'result'.
            do{
                
                result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
                
                
            } catch{
                let fetchError = error as NSError
                print(fetchError)
            }
        
        // 3 - Return array of 'result'.
            return result
    }
    
    
    
    /*Used to delete objects specified by 'result' from a given entity.*/
    func deleteFromEntity(result:[AnyObject]){
        // 1 - Loop through array of 'result'.
            for managedObject in result {
                // 2 - Delete specified object from entity.
                    self.managedObjectContext.deleteObject(managedObject as! NSManagedObject)
                // 3 - Save changes to persistent store.
                    self.saveManagedContext()
            }
    }
    
    
    
    
    /*Used to evaluate if a specified object is within an entity's object graph.*/
    func evaluateIfInDB(nameOfEntity: String, nameOfKey: String, nameOfObject: String)->Bool{
        var evalVal: Bool!
        
        // 1 - Fetching
             let fetchRequest = get_fetchRequest(nameOfEntity, nameOfKey: nameOfKey, nameOfObject: nameOfObject)
        
        // 2 - Get array of NSAnyObject
            let result = get_result(fetchRequest)
        
        // 3 - Evaluate.
            if(result.count == 0){
                
                evalVal = false
            }
            else{
                evalVal = true
            }
        
        // 4 - Return 'evalVal'.
            return evalVal
    }
    
    
   
    
    
    
}