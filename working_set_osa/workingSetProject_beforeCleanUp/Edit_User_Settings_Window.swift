//
//  Edit_User_Settings_Window.swift
//  workingSetProject
//
//  Created by Osa on 6/22/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class Edit_User_Settings_Window: NSViewController {

    
    
    @IBOutlet weak var File_Directory_Label: NSTextField!
    
    
    @IBOutlet weak var Serial_Port_Label: NSPopUpButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @IBAction func OK_Button(sender: AnyObject) {
        
        //Save user changes here. Close window.
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
    
    
    
    @IBAction func Cancel_Button(sender: AnyObject) {
        
        //No action taken. Close window.
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
    
    
    
}
