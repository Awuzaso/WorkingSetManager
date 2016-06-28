//
//  New_WS_Function.swift
//  workingSetProject
//
//  Created by Osa on 6/15/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Foundation
import Cocoa
import CoreData

var workingSets = [NSManagedObject]() //Stores instances of entity 'Working-Set'

func addNewMember(nameOfWS: String){
    let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
    let windowObject = windowManager()
    //let path = "/Users/Osa/Desktop/"
    let n_path = appDelegate.coreDataObject.getSingleObjectAttrib("User_Attrib", nameOfKey: "pathToSaveWS")
    let path = "\(n_path)"
    
   
     
     
     let coreDataObject = appDelegate.coreDataObject
     
    coreDataObject.addEntityObject("Working_Set", nameOfKey: "smartFOlder", nameOfObject: nameOfWS)
  
    
    windowObject.createNewFile(path, nameOfFile: nameOfWS)
    
    
    

}