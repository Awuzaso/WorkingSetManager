//
//  Edit_WS_Window.swift
//  workingSetProject
//
//  Created by Osa on 6/4/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa




class Edit_WS_Window: NSViewController {

   let editWindowObject = windowManager()
   
    var oldWSname = "Value"

    
    @IBOutlet weak var nameOfWS: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @IBAction func dismissEditWindow(sender: NSButton) {
        editWSFunc(oldWSname, new_nameOfWS: nameOfWS.stringValue)
        editWindowObject.setWindow()
    }
    
    @IBAction func CancelWindow(sender: NSButton) {
        editWindowObject.setWindow()
    }
}
