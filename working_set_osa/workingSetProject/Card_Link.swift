//
//  Associate_Card_Window.swift
//  workingSetProject
//
//  Created by Osa on 6/22/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class Card_Link_Window: NSViewController {
    let launchWindowTable = tableViewManager()
    let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate

    /*Variables*/
    var nameOfWS: String! //Selected WS
    var workingSets = [NSManagedObject]() //Stores instances of entity 'Working-Set'
    
    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var statusLabel: NSTextField!
    
   
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        tableView!.setDelegate(self)
        tableView!.setDataSource(self)
        tableView!.target = self
        
    }
    
    /*This function is called everytime there is a change in the table view.*/
    func updateStatus() {
        // 1 - Get collection of objects from object graph.
        workingSets = appDelegate.coreDataObject.getDataObjects("Working_Set")
 
        // 2 - Set the current selection of working set from table view.
        let item = workingSets[tableView!.selectedRow]
       
        nameOfWS =  launchWindowTable.getItemSelected_String(tableView, managedObjectArray: workingSets, objectAttr: "SmartFOlder")
        print(nameOfWS)
        // 3 - Change the status label beneath the table view dynamically as selection changes.
        statusLabel.stringValue = launchWindowTable.getStatusOfItemsSelected(tableView, itemCount: workingSets.count)
  
    }
    
    override func awakeFromNib() {
        
    }
    
    
    
    @IBAction func OK_Button(sender: NSButton){
        
        let dataCore = appDelegate.coreDataObject
        let cardID = appDelegate.cardValue
        dataCore.setValueOfEntityObject("Working_Set", nameOfKey: "tagID", oldName: nameOfWS, editName: cardID)
        
        print(cardID)
        
        
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
    
    @IBAction func Cancel_Button(sender: NSButton){
        let application = NSApplication.sharedApplication()
        application.stopModal()
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

extension Card_Link_Window : NSTableViewDataSource {
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        
        //1
        let appDelegate =
            NSApplication.sharedApplication().delegate as! AppDelegate
        //let managedContext = appDelegate.managedObjectContext
        let managedContext = appDelegate.coreDataObject.managedObjectContext
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
    
    /*
    func tableView(tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
        print("Sorting.")
        // 1
        guard let sortDescriptor = tableView.sortDescriptors.first else {
            return
        }
        if let order = Directory.FileOrder(rawValue: sortDescriptor.key! ) {
            // 2
            sortOrder = order
            sortAscending = sortDescriptor.ascending
            reloadFileList()
        }
    }
    */
    
}

extension Card_Link_Window : NSTableViewDelegate {
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        updateStatus()
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        
        var text:String = ""
        var cellIdentifier: String = ""
        
        
        //1
        let appDelegate =
            NSApplication.sharedApplication().delegate as! AppDelegate
        //let managedContext = appDelegate.managedObjectContext
        let managedContext = appDelegate.coreDataObject.managedObjectContext
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


