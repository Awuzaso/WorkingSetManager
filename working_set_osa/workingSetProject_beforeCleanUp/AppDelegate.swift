//
//  AppDelegate.swift
//  testCore
//
//  Created by Osa on 6/5/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa
import CoreData
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var coreDataObject = dataCore()
    func applicationDidFinishLaunching(aNotification: NSNotification) {
                // Insert code here to initialize your application
        
        print("Starting.")
       
        
        
        
        
    }
    
    @IBAction func testAct(sender: AnyObject!){
        /*
        
         //1
         var managedObjectContext: NSManagedObjectContext!
         
         let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
         
         let managedContext = appDelegate.managedObjectContext
         
        
         //let managedObjectContext = self.managedObjectContext
         var countOfEntity: Int
         
         let fetchRequest = NSFetchRequest(entityName: "User_Attrib")
         
         do{
         
         //let result = try self.managedObjectContext.executeRequest(fetchRequest)
         let result = try self.managedObjectContext.countForFetchRequest(fetchRequest, error: nil)
         
         countOfEntity = result
         
         } catch{
         let fetchError = error as NSError
         print(fetchError)
         }
        
         //Here the program should evaluate if the program is being run for the first time.
         
         // Program should evaluate the CoreData object graph for entity UserAttrib.
         
         // Scenario 1: If there are is no user data member for "UserAttrib", it will create a new one.
         // Launch window associated with "UserAttrib"
         // Scenario 2: If there is a member, no action needs to be taken.
         
         
         if(countOfEntity == 0){
         
            /////MESSSSS
            //1
            let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            
            
            //2
            let entity = NSEntityDescription.entityForName("User_Attrib", inManagedObjectContext: managedContext)
       
            
            
            let userSetting = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
           
            
            //3
            //workingSet.setValue(nameOfWS, forKey: "smartFOlder")
            
            userSetting.setValue(false, forKey: "ifFirstTime")
            userSetting.setValue("/Users/Osa/Desktop", forKey: "pathToSaveWS")
            userSetting.setValue("/dev/cu.usbmodem1411", forKey: "serialPortPath")
            //4
            do {
                try managedContext.save()
                //5
                //workingSets.append(workingSet)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            
            
            
            
            
            ////MESSSSS
         
         // 1
         let storyboard = NSStoryboard(name: "Main", bundle: nil)
         let editUserSettingWindowController = storyboard.instantiateControllerWithIdentifier("Edit User Settings Window") as! NSWindowController
       
         if let editUserSetting_Window = editUserSettingWindowController.window{
         
         // 3
         let application = NSApplication.sharedApplication()
         application.runModalForWindow(editUserSetting_Window)
         }
          //
         
         //
         }
        */

        
        
        
        
        
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    /*
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
    */
}
