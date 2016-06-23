//
//  WindowManagerClass.swift
//  workingSetProject
//
//  Created by Osa on 6/22/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class windowManager{
    
    var nameOfWindow = "Window"
    
    func setWindow(){
        let application = NSApplication.sharedApplication()
        application.stopModal()
    }
    
    
    func openWindow( nameOfPath: String, nameOfFile: String){
        let filePath = "\(nameOfPath)\(nameOfFile)"
        NSWorkspace.sharedWorkspace().selectFile(nil, inFileViewerRootedAtPath: filePath)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
