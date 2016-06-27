//
//  Disassociate_Card_Window.swift
//  workingSetProject
//
//  Created by Osa on 6/22/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class Disassociate_Card_Window: NSViewController {

    
    @IBOutlet weak var Disassociate_Card_Message: NSTextField!
    
    var message = "Working Set X"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        Disassociate_Card_Message.stringValue = "Are you sure you want to disassociate this card from \(message) ?"
    }
    
    
    @IBAction func OK_Button(sender: AnyObject) {
        // 1 - Delete "tagID" attribute from object.
        
        
        // 2 - Close events for window.
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
    
    
    @IBAction func Cancel_Button(sender: AnyObject) {
        // 1 - Close events for window.
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
    
    
}
