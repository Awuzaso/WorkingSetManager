//
//  Edit_User_Settings_Window.swift
//  workingSetProject
//
//  Created by Osa on 6/22/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class Edit_User_Settings_Window: NSViewController {
    let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
    
    
    @IBOutlet weak var File_Directory_Label: NSTextField!
    
    
    @IBOutlet weak var Serial_Port_Label: NSPopUpButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    
    @IBAction func OpenWindowForDirectory_Button(sender: AnyObject) {
        
        //let storyboard = NSStoryboard(name: "Main", bundle: nil)
        //let openWindowController = storyboard.instantiateControllerWithIdentifier("Edit User Settings Window") as! NSWindowController
        
        /*
        let openPanel = NSOpenPanel()
        openPanel.showsHiddenFiles      = false
        openPanel.canChooseFiles        = false
        openPanel.canChooseDirectories  = true
        
        openPanel.beginSheetModalForWindow(self.window!) {
            (response) -> Void in
            guard response == NSFileHandlingPanelOKButton else {
                return;
            }
            //self.contentViewController?.representedObject = openPanel.URL
        }
        */
        //let winCon = WindowController()
        //winCon.openDocument(nil)
        
        
        
        
    }
  

        
    
        
    
    
    
    
    
    @IBAction func OK_Button(sender: AnyObject) {
        
        //Save user changes here. Close window.
        
        let dataCore = appDelegate.coreDataObject
        
        dataCore.editEntityObject("User_Attrib", nameOfKey: "pathToSaveWS", oldName: "N/A", editName: File_Directory_Label.stringValue)
        
        let selectedIndex = Serial_Port_Label.indexOfSelectedItem
        dataCore.editEntityObject("User_Attrib", nameOfKey: "pathToSaveWS", oldName: "N/A", editName: Serial_Port_Label.itemTitleAtIndex(selectedIndex))
        
        print(File_Directory_Label.stringValue)
          print(Serial_Port_Label.itemTitleAtIndex(selectedIndex))
        
        
        
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
    
    
    
    @IBAction func Cancel_Button(sender: AnyObject) {
        
        //No action taken. Close window.
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
    
    
    
}
