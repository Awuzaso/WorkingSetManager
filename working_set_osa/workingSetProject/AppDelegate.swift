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
    var cardValue: String!
    var coreDataObject = dataCore()
    let userPref = UserPrefManager()
    
    var filePath:String {
        get{
            return userPref.get_fileDirectory(&coreDataObject)
        }
    }
    //var serialPath:String! = nil
    var serialPath:String {
        get{
            return userPref.get_serialPort(&coreDataObject)
        }
    }
    
    var serialPortObject: SerialPortManager!
    func set_CardValue(value:String){
        cardValue = value
        print(cardValue)
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
            serialPortObject = SerialPortManager(pathName: /*serialPath*/"/dev/cu.usbmodem1411",in_nameOfStoryBoard: "Main" ,in_nameOfWinUnAssoc:"UAWindow",  in_nameOfWinAssoc: "AWindow")
            evaluateIfFirstTime()
    }
    
    func evaluateIfFirstTime(){
        
        
        var countOfEntity: Int
        
        let fetchRequest = NSFetchRequest(entityName: "User_Attrib")
        
        do{
            
            //let result = try self.managedObjectContext.executeRequest(fetchRequest)
            let result = try coreDataObject.managedObjectContext.countForFetchRequest(fetchRequest, error: nil)
            
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
            print("No user profile detected.")
            
            /////MESSSSS
            //1
            _ = NSApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = coreDataObject.managedObjectContext
            
            
            
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
        }
        else{
            print("User profile detected.")
            //testAct(nil)
        }

    }
    
    @IBAction func openUserSettingWindow_Button(sender: AnyObject!){
        // 1 - Setting window object.
        let openWindowObject = windowManager()
        openWindowObject.setWindow("Main",nameOfWindowController: "Edit User Settings Window")
        // 2 - Initiate the window.
        openWindowObject.runModalWindow()
    }
    
    
    @IBAction func openDevAssocCardWin(sender: AnyObject!){
        // 1 - Setting window object.
        let openWindowObject = windowManager()
        openWindowObject.setWindow("Main",nameOfWindowController: "AWindow")
        // 2 - Initiate the window.
        openWindowObject.runModalWindow()
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
}

