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
    
    var nameOfWS_title:String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
            Associated_Card_Message.stringValue = "An associated card with \(nameOfWS_title) has been detected. Select an option."
    }
    
    
    
    @IBAction func Open_Associated_WS(sender: NSButton) {
        
        // 1 - Setting window object.
            let openWindowObject = windowManager()
            openWindowObject.setWindow("Main",nameOfWindowController: "Open WS")
        // 2 - Setting the values of the window object.
            let openWindowController = openWindowObject.get_windowController()
            let openWindowViewController = openWindowController.contentViewController as! Open_WS_Window
        print(nameOfWS_title)
            openWindowViewController.nameOfWS.stringValue = nameOfWS_title
        // 3 - Initiate the window.
            openWindowObject.runModalWindow()

        // 4 - Close events for window.
            let application = NSApplication.sharedApplication()
            application.stopModal()
        
    }
    
    
    @IBAction func Reassociate_WS(sender: NSButton) {
        
        // 1 - Setting window object.
            let openWindowObject = windowManager()
            openWindowObject.setWindow("Main",nameOfWindowController: "Card Link Window")
        // 2 - Initiate the window.
            openWindowObject.runModalWindow()
        
        // 3 - End window events.
            let application = NSApplication.sharedApplication()
            application.stopModal()
    }
    
    @IBAction func Disassociate_WS(sender: NSButton) {
        
        // 1 - Setting window object.
            let openWindowObject = windowManager()
            openWindowObject.setWindow("Main",nameOfWindowController: "Dis_Win")
        
        // 2 - Initiate the window.
            openWindowObject.runModalWindow()
        
        // 3 - Close events for window.
            let application = NSApplication.sharedApplication()
            application.stopModal()
        
    }
    
    @IBAction func Cancel(sender: NSButton) {
        // 1 - Close events for window.
            let application = NSApplication.sharedApplication()
            application.stopModal()
        
    }
    
    
    
}
