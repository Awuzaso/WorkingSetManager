//
//  Edit_WS_Window.swift
//  workingSetProject
//
//  Created by Osa on 6/4/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa




class Edit_WS_Window: NSViewController {

    /* Note: Var 'managedObjectContext', holds object of class, 'NSManagedObjectContext',
     responible for creating a representational "scratchpad" or "object space" to work with
     managed objects (Entities of CoreData object graph.)                               */
    //var managedObjectContext: NSManagedObjectContext!
    

    
    @IBOutlet weak var nameOfWS: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @IBAction func dismissEditWindow(sender: NSButton) {
        
        let application = NSApplication.sharedApplication()
        
        editWSFunc(nameOfWS.stringValue)
        application.stopModal()
    }
    
    @IBAction func CancelWindow(sender: NSButton) {
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
}
