//
//  View_Controller_Extension.swift
//  workingSetProject
//
//  Created by Osa on 6/23/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa


extension ViewController : NSTableViewDataSource {
    
    
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


