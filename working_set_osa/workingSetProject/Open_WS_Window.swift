//
//  Open_WS_Window.swift
//  workingSetProject
//
//  Created by Osa on 6/4/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class Open_WS_Window: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @IBAction func dismissOpenWindow(sender: NSButton) {
        
       let smartFolder = "/Users/Osa/Desktop"
        
        NSWorkspace.sharedWorkspace().selectFile(nil, inFileViewerRootedAtPath: smartFolder)
        
        
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
    
    @IBAction func CancelWindow(sender: NSButton) {
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
}
