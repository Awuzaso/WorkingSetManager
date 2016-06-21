//
//  New_WS_Window.swift
//  workingSetProject
//
//  Created by Osa on 6/4/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa
import CoreData

class New_WS_Window: NSViewController {

    @IBOutlet weak var nameOfWS: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func awakeFromNib() {
        nameOfWS.stringValue = "Name of Working set"
    }
    
    @IBAction func dismissNewWindow(sender: NSButton) {
        
        let application = NSApplication.sharedApplication()
        
        addNewMember(nameOfWS.stringValue)
      
        application.stopModal()
        
    }
    
    @IBAction func CancelWindow(sender: NSButton){
        
        let application = NSApplication.sharedApplication()
        
        application.stopModal()
        
    }
}
