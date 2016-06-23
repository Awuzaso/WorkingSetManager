//
//  Associated_Card_Window.swift
//  workingSetProject
//
//  Created by Osa on 6/22/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class Associated_Card_Window: NSViewController {

    
    @IBOutlet weak var Associated_Card_Message: NSTextField!
    
    var nameOfWS_title = "Working Set X"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        Associated_Card_Message.stringValue = "An associated card with \(nameOfWS_title) has been detected. Select an option."
    }
    
    
    
    @IBAction func Open_Associated_WS(sender: NSButton) {
        let application = NSApplication.sharedApplication()
        application.stopModal()
        
    }
    
    
    @IBAction func Reassociate_WS(sender: NSButton) {
        let application = NSApplication.sharedApplication()
        application.stopModal()
        
    }
    
    @IBAction func Disassociate_WS(sender: NSButton) {
        let application = NSApplication.sharedApplication()
        application.stopModal()
        
    }
    
    @IBAction func Cancel(sender: NSButton) {
        let application = NSApplication.sharedApplication()
        application.stopModal()
        
    }
    
    
    
}
