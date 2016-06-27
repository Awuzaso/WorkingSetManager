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
    
    override func awakeFromNib() {
        
    }
    
    @IBAction func newWindow(sender: AnyObject) {
        // 1 - Setting window object.
            let openWindowObject = windowManager()
            openWindowObject.setWindow("Main",nameOfWindowController: "New WS")
        // 2 - Initiate the window.
            openWindowObject.runModalWindow()
        // 3 - Reload contents of table view.
            reloadFileList()
    }
    
    
    @IBAction func openWindow(sender: AnyObject) {
        // 1 - Setting window object.
            let openWindowObject = windowManager()
        openWindowObject.setWindow("Main",nameOfWindowController: "Open WS")
        // 2 - Setting the values of the window object.
            let openWindowController = openWindowObject.get_windowController()
            let openWindowViewController = openWindowController.contentViewController as! Open_WS_Window
            openWindowViewController.nameOfWS.stringValue = nameOfWS
        // 3 - Initiate the window.
            openWindowObject.runModalWindow()
    }
    
    @IBAction func editWindow(sender: AnyObject) {
        
        // 1 - Setting window object.
            let openWindowObject = windowManager()
            openWindowObject.setWindow("Main",nameOfWindowController: "Edit WS")
        // 2 - Setting the values of the window object.
            let openWindowController = openWindowObject.get_windowController()
            let openWindowViewController = openWindowController.contentViewController as! Edit_WS_Window
            openWindowViewController.nameOfWS.stringValue = nameOfWS
            openWindowViewController.oldWSname = nameOfWS
        // 3 - Initiate the window.
            openWindowObject.runModalWindow()
        // 4- Reload contents of table view.
            reloadFileList()
    }
    
    @IBAction func deleteWindow(sender: AnyObject) {
        
        // 1 - Setting window object.
            let openWindowObject = windowManager()
            openWindowObject.setWindow("Main",nameOfWindowController: "Delete WS")
        // 2 - Setting the values of the window object.
            let openWindowController = openWindowObject.get_windowController()
            let openWindowViewController = openWindowController.contentViewController as! Delete_WS_Window
            openWindowViewController.nameOfWS.stringValue = nameOfWS
        // 3 - Initiate the window.
            openWindowObject.runModalWindow()
        // 4 - Disable the buttons on launch window.
            switchOnOffButtons(false)
        // 5- Reload contents of the table view.
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
