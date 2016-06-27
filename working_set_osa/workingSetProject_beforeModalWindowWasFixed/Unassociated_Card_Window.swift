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
        
        // 1
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let openWindowController = storyboard.instantiateControllerWithIdentifier("Card Link Window") as! NSWindowController
        
        // 2
        if let openWS_Window = openWindowController.window{
            
            
            //let  open_WS_WindowController = openWS_Window.contentViewController as! Open_WS_Window
            
            //open_WS_WindowController.nameOfWS.stringValue = nameOfWS
            
            // 3
            let application = NSApplication.sharedApplication()
            application.runModalForWindow(openWS_Window)
        }

        
        
        
    }
    
    
    @IBAction func Cancel(sender: AnyObject) {
        
        
        
        
        
    }
    
    
    
}
