//
//  Delete_WS_Window.swift
//  workingSetProject
//
//  Created by Osa on 6/4/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa
import CoreData

class Delete_WS_Window: NSViewController {
    
    
    
    
    
    @IBOutlet weak var nameOfWS: NSTextField!
    
    //var workingSets = [NSManagedObject]() //Stores instances of entity 'Working-Set'
    
    override func viewDidLoad() {
        super.viewDidLoad()
                   // Do view setup here.
    }
    
    
    @IBAction func DeleteNewWindow(sender: NSButton) {
        let application = NSApplication.sharedApplication()
        
        
        
        DeleteFunc(nameOfWS.stringValue)

        application.stopModal()
    }
    
    @IBAction func CancelWindow(sender: NSButton) {
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
}