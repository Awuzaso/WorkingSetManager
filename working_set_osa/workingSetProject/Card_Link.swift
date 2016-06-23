//
//  Associate_Card_Window.swift
//  workingSetProject
//
//  Created by Osa on 6/22/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class Card_Link_Window: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func OK_Button(sender: NSButton){
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
    
    @IBAction func Cancel_Button(sender: NSButton){
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
    
    
    
    
    
    
}
