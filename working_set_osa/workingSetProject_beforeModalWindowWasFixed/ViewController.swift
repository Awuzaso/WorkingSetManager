//
//  ViewController.swift
//  workingSetProject
//
//  Created by Osa on 6/4/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa
import CoreData

class ViewController: NSViewController {

    let launchWindowTable = tableViewManager()
    /*Declaring delegates to use within scope of class*/
    let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
    
    
    /*Variables for Sorting Table View*/
    var sortOrder = Directory.FileOrder.Name
    var sortAscending = true
    
    /*Outlets for Buttons*/
    @IBOutlet weak var NewButton: NSButton!
    @IBOutlet weak var OpenButton: NSButton!
    @IBOutlet weak var EditButton: NSButton!
    @IBOutlet weak var DeleteButton: NSButton!
    
    /*Outlets for Table View*/
    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    
    
    /*Variables*/
    var nameOfWS: String! //Selected WS
    var workingSets = [NSManagedObject]() //Stores instances of entity 'Working-Set'
    
    /*Function for toggling between off and on state of buttons.*/
    func switchOnOffButtons(isActive:Bool){
        OpenButton.enabled = isActive
        EditButton.enabled = isActive
        DeleteButton.enabled = isActive
    }
    
    /*Set-up View*/
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView!.setDelegate(self)
        tableView!.setDataSource(self)
        tableView!.target = self
        
        //Setting up sorting configuration:
        // 1
        let descriptorName_01 = NSSortDescriptor(key: Directory.FileOrder.Name.rawValue, ascending: true)
        let descriptorName_02 = NSSortDescriptor(key: Directory.FileOrder.Name.rawValue, ascending: true)
        
        // 2
        tableView.tableColumns[0].sortDescriptorPrototype = descriptorName_01;
        tableView.tableColumns[0].sortDescriptorPrototype = descriptorName_02;
        
        switchOnOffButtons(false)
        
    }
    
    

    /*This function is called everytime there is a change in the table view.*/
    func updateStatus() {
        // 1 - Get collection of objects from object graph.
        workingSets = appDelegate.coreDataObject.getDataObjects("Working_Set")
       
        // 2 - Set the current selection of working set from table view.
        let item = workingSets[tableView!.selectedRow]
        nameOfWS =  launchWindowTable.getItemSelected_String(tableView, managedObjectArray: workingSets, objectAttr: "SmartFOlder")       /*item.valueForKey("smartFOlder") as? String*/
        
        // 3 - Change the status label beneath the table view dynamically as selection changes.
        statusLabel.stringValue = launchWindowTable.getStatusOfItemsSelected(tableView, itemCount: workingSets.count)

        // 4 - When a working set is seleted from the table view, launch window buttons are then made available to be pressed.
        switchOnOffButtons(true)
    }
    
   
    
    override func awakeFromNib() {
        
    }
    
    
    
    @IBAction func newWindow(sender: AnyObject) {
        
        // 1
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let newWindowController = storyboard.instantiateControllerWithIdentifier("New WS") as! NSWindowController
    
        // 2
        if let newWS_Window = newWindowController.window{
            
          
            // 3
            let application = NSApplication.sharedApplication()
            
            let session = application.beginModalSessionForWindow(newWS_Window)
        
            var value:Bool = false
            
            while(value == false){
            
                if( application.runModalSession(session) == NSModalResponseStop ){
                    print("Closing.")
                    value = true
                }
                
              
            }
            
            application.endModalSession(session)
            
            print("Out of loop")
          
        }
        reloadFileList()
    }
    
    
    @IBAction func openWindow(sender: AnyObject) {
        ///*
        let openWindowObject = windowManager()
        openWindowObject.setWindow("Main",nameOfWindowController: "Open WS")
        let openWindowController = openWindowObject.get_windowController()
        let openWindowViewController = openWindowController.contentViewController as! Open_WS_Window
        openWindowViewController.nameOfWS.stringValue = nameOfWS
        openWindowObject.runModalWindow()
        //*/
        /*
        // 1
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let openWindowController = storyboard.instantiateControllerWithIdentifier("Open WS") as! NSWindowController
        
        // 2
        if let openWS_Window = openWindowController.window{
            
            
            let  open_WS_WindowController = openWS_Window.contentViewController as! Open_WS_Window
             print(nameOfWS)
             open_WS_WindowController.nameOfWS.stringValue = nameOfWS
            
            // 3
            let application = NSApplication.sharedApplication()
            application.runModalForWindow(openWS_Window)
        }
        */
    }
    
    @IBAction func editWindow(sender: AnyObject) {
        
        // 1
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let editWindowController = storyboard.instantiateControllerWithIdentifier("Edit WS") as! NSWindowController
        
        if let editWS_Window = editWindowController.window/*, textStorage = text.textStorage */{
            
            // 2
            let edit_WS_WindowController = editWS_Window.contentViewController as! Edit_WS_Window
             edit_WS_WindowController.nameOfWS.stringValue = nameOfWS
             edit_WS_WindowController.oldWSname = nameOfWS
            // 3
            let application = NSApplication.sharedApplication()
            application.runModalForWindow(editWS_Window)
        }
        reloadFileList()
    }
    
    @IBAction func deleteWindow(sender: AnyObject) {
        
        // 1
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let delWindowController = storyboard.instantiateControllerWithIdentifier("Delete WS") as! NSWindowController
        
        if let delWS_Window = delWindowController.window/*, textStorage = nameOfWS */{
            
            // 2
            let delete_WS_WindowController = delWS_Window.contentViewController as! Delete_WS_Window
             delete_WS_WindowController.nameOfWS.stringValue = nameOfWS
 
            
            // 3
            let application = NSApplication.sharedApplication()
            application.runModalForWindow(delWS_Window)
        }
        
        OpenButton.enabled = false
        EditButton.enabled = false
        DeleteButton.enabled = false
        
        reloadFileList()
 
    }
    
   
    func reloadFileList() {
        //directoryItems = directory?.contentsOrderedBy(sortOrder, ascending: sortAscending)
        tableView!.reloadData()
        
    }
    

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        reloadFileList()
        }
    }

    
    
}
