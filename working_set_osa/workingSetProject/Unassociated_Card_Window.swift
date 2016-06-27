//
//  Unassociated_Card_Window.swift
//  workingSetProject
//
//  Created by Osa on 6/22/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class Unassociated_Card_Window: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @IBAction func Associate_WS(sender: AnyObject) {
        
        // 1 - Setting window object.
        let openWindowObject = windowManager()
        openWindowObject.setWindow("Main",nameOfWindowController: "Card Link Window")
        // 2 - Initiate the window.
        openWindowObject.runModalWindow()
        
        // 3 - End window events.
        let application = NSApplication.sharedApplication()
        application.stopModal()

        
    }
    
    
    @IBAction func Cancel(sender: AnyObject) {
        // 1 - End window events.
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
    
    
    
}
