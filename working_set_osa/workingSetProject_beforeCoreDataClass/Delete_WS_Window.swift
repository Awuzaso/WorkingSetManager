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
    
    let deleteWindowObject = windowManager()
    
    @IBOutlet weak var nameOfWS: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do view set-up here.
    }
    
    
    @IBAction func DeleteNewWindow(sender: NSButton) {
        
        DeleteFunc(nameOfWS.stringValue)
        
        deleteWindowObject.setWindow()
    }
    
    @IBAction func CancelWindow(sender: NSButton) {
        deleteWindowObject.setWindow()
    }
}