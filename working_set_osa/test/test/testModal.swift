//
//  testModal.swift
//  test
//
//  Created by Osa on 6/21/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class testModal: NSViewController {

    
    @IBOutlet weak var testModalLabel: NSTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @IBAction func testModalOKButton(sender: AnyObject) {
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
    
}
