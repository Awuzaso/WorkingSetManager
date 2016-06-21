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

    
    /*Outlets for Buttons*/
    @IBOutlet weak var NewButton: NSButton!
    @IBOutlet weak var OpenButton: NSButton!
    @IBOutlet weak var EditButton: NSButton!
    @IBOutlet weak var DeleteButton: NSButton!
    
    /*Outlets for Table View*/
    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    
    
    /*Variables*/
    var nameOfWS: String!
    var workingSets = [NSManagedObject]() //Stores instances of entity 'Working-Set'
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.setDelegate(self)
        tableView.setDataSource(self)
        tableView.target = self
        OpenButton.enabled = false
        EditButton.enabled = false
        DeleteButton.enabled = false
    }
    
    
    func updateStatus() {
        
        
        //1
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Working_Set")
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            workingSets = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

       
        
        
        let text:String
        // 1
        let itemsSelected = tableView.selectedRowIndexes.count
        
        // 2
        if ( workingSets.count == 0 ) {
            text = ""
        }
        else if( itemsSelected == 0 ) {
            text =   "\(workingSets.count) items"
        }
        else
        {
            text = "\(itemsSelected) of \(workingSets.count) selected"
        }
        OpenButton.enabled = true
        EditButton.enabled = true
        DeleteButton.enabled = true

        // 3
        statusLabel.stringValue = text
       
       /////////////////////
        let item = workingSets[tableView.selectedRow]
        
        if(tableView.selectedRow >= 0){
            
        }
        else{
            return
        }
        
        
        
        nameOfWS = item.valueForKey("smartFOlder") as? String

    }
    
    
    func tableViewDoubleClick(sender: AnyObject) {
        
    }
    
    override func awakeFromNib() {
        
    }
    
    
    
    @IBAction func newWindow(sender: AnyObject) {
        
        // 1
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let newWindowController = storyboard.instantiateControllerWithIdentifier("New WS") as! NSWindowController
    
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
        
        // 1
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let openWindowController = storyboard.instantiateControllerWithIdentifier("Open WS") as! NSWindowController
        
        if let openWS_Window = openWindowController.window/*, textStorage = text.textStorage */{
            
            // 2
            let  open_WS_WindowController = openWS_Window.contentViewController as! Open_WS_Window
             print(nameOfWS)
             open_WS_WindowController.nameOfWS.stringValue = nameOfWS
            
            // 3
            let application = NSApplication.sharedApplication()
            application.runModalForWindow(openWS_Window)
        }
    }
    
    @IBAction func editWindow(sender: AnyObject) {
        
        // 1
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let editWindowController = storyboard.instantiateControllerWithIdentifier("Edit WS") as! NSWindowController
        
        if let editWS_Window = editWindowController.window/*, textStorage = text.textStorage */{
            
            // 2
            let edit_WS_WindowController = editWS_Window.contentViewController as! Edit_WS_Window
             edit_WS_WindowController.nameOfWS.stringValue = nameOfWS
            
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
        tableView.reloadData()
    }
    

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        reloadFileList()
        }
    }

    
    
}

extension ViewController : NSTableViewDataSource {
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        
        //1
        let appDelegate =
            NSApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Working_Set")
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            workingSets = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return workingSets.count ?? 0
    }
}

extension ViewController : NSTableViewDelegate {
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        updateStatus()
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
       
        var text:String = ""
        var cellIdentifier: String = ""
        
        
        //1
        let appDelegate =
            NSApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Working_Set")
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            workingSets = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

        /////////////
        var value = workingSets[row].valueForKey("smartFOlder") as? String
        
        
        if(value == nil){
            value = "Unnamed"
        }
        
        // 2
        if tableColumn == tableView.tableColumns[0] {
            //image = item.icon
           
            text = value!
            cellIdentifier = "NameCellID"
        } else if tableColumn == tableView.tableColumns[1] {
            text = "Value"
            cellIdentifier = "DateCellID"
        }
        // 3
        if let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            //cell.imageView?.image = image ?? nil
            return cell
        }
        return nil
    }
}