//
//  Open_WS_Window.swift
//  workingSetProject
//
//  Created by Osa on 6/4/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class Open_WS_Window: NSViewController {

    let openWindowObject = windowManager()
    
    var managedObjectContext: NSManagedObjectContext!
    
    let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
    
    
    var filePath: String = "/Users/Osa/Desktop/"
    
    @IBOutlet weak var nameOfWS: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @IBAction func dismissOpenWindow(sender: NSButton) {
        let n_path = appDelegate.coreDataObject.getSingleObjectAttrib("User_Attrib", nameOfKey: "pathToSaveWS")
        let path = "\(n_path)"
        openWindowObject.openWindow(path ,nameOfFile: nameOfWS.stringValue)
        openWindowObject.setWindow()
    }
    
    @IBAction func CancelWindow(sender: NSButton) {
        openWindowObject.setWindow()
    }
}
