//
//  Card_Link_Window_Extension.swift
//  workingSetProject
//
//  Created by Osa on 6/28/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa


extension Card_Link_Window : NSTableViewDataSource {
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        
        //1
        let appDelegate =
            NSApplication.sharedApplication().delegate as! AppDelegate
        
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

