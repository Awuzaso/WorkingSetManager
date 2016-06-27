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
    let userPref = UserPrefManager()
    let serialPortManager = ORSSerialPortManager.sharedSerialPortManager()
    @IBOutlet weak var File_Directory_Label: NSTextField!
    
    
    @IBOutlet weak var Serial_Port_Label: NSPopUpButton!
    
    func initializePopUp(){
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func OpenWindowForDirectory_Button(sender: AnyObject) {

        
    }
  
    
    @IBAction func OK_Button(sender: AnyObject) {
        
        //Save user changes here. Close window.
        
        var dataCore = appDelegate.coreDataObject
     
        let selectedIndex = Serial_Port_Label.indexOfSelectedItem
        let port = Serial_Port_Label.itemTitleAtIndex(selectedIndex)
        let portPath = "/dev/cu."+port
        print(portPath)
        userPref.set_fileDirectory(&dataCore, filePath: File_Directory_Label.stringValue)
        userPref.set_serialPort(&dataCore, portPath: portPath)
        
        
        //Test if it works:
        print(dataCore.getSingleObjectAttrib("User_Attrib", nameOfKey: "pathToSaveWS"))
        //print(dataCore.getSingleObjectAttrib("User_Attrib", nameOfKey: "serialPortPath"))
        
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
    
    
    
    @IBAction func Cancel_Button(sender: AnyObject) {
        
        //No action taken. Close window.
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
    
    
    
}
