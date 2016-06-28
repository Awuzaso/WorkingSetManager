//
//  Associate_Card_Window.swift
//  workingSetProject
//
//  Created by Osa on 6/22/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class Card_Link_Window: NSViewController {
    /*Constants*/
    let launchWindowTable = tableViewManager()
    let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate

    /*Variables*/
    var nameOfWS: String! //Selected WS
    var workingSets = [NSManagedObject]() //Stores instances of entity 'Working-Set'
    
    /*Outlets*/
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var statusLabel: NSTextField!
    
    /*Set-up function.*/
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
        
        // 3 - Change the status label beneath the table view dynamically as selection changes.
            statusLabel.stringValue = launchWindowTable.getStatusOfItemsSelected(tableView, itemCount: workingSets.count)
  
    }
    
    /*"Awake from nib" function.*/
    override func awakeFromNib() {
        
    }
    
    
    /*Interface builder action function for "OK" button.*/
    @IBAction func OK_Button(sender: NSButton){
        // 1 - Retrieve the 'coreDataObject' and 'cardValue' objects.
            let dataCore = appDelegate.coreDataObject
            let cardID = appDelegate.cardValue
        
        // 2 - Associate the cardID with the chosen working set from the menu
            dataCore.setValueOfEntityObject("Working_Set", nameOfKey: "tagID", oldName: nameOfWS, editName: cardID)
        //print("Making association.")
            //dataCore.new_editEntityObject("Working_Set", nameOfSearchKey: "SmartFOlder", searchAttr: nameOfWS, newAttrKey: "tagID", newAttr: cardID)
        // 3 - End events for window.
            let application = NSApplication.sharedApplication()
            application.stopModal()
    }
    
    /*Interface builder action function for "Cancel" button.*/
    @IBAction func Cancel_Button(sender: NSButton){
        // 1 - End events for window.
            let application = NSApplication.sharedApplication()
            application.stopModal()
    }
}

