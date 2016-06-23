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
    
    
    func createNewFile( nameOfPath: String, nameOfFile: String){
        let filePath = "\(nameOfPath)\(nameOfFile)"
       
        
        do {
            //var deliverablePathString = "/Users/Osa/Desktop/\(nameOfWS)"
            try NSFileManager.defaultManager().createDirectoryAtPath(filePath, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            NSLog("\(error.localizedDescription)")
        } catch {
            print("general error - \(error)")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
