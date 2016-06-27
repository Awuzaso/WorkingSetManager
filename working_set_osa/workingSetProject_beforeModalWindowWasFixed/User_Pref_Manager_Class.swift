//
//  User_Pref_Manager_Class.swift
//  workingSetProject
//
//  Created by Osa on 6/26/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa


class UserPrefManager{
    


    
    
   
    
    
    
    
    func set_fileDirectory(inout coreDataObject:dataCore,filePath:String){
        /* 1 - Get the entity.*/
        /* 2 - Set the attribute for file directory for entity.*/
        coreDataObject.setSingleObjectAttrib("User_Attrib",nameOfKey: "pathToSaveWS",value: filePath)
    }
    
    func set_serialPort(inout coreDataObject:dataCore,portPath:String){
        /* 1 - Get the entity.*/
        /* 2 - Set the attribute for serial port for entity.*/
        coreDataObject.setSingleObjectAttrib("User_Attrib",nameOfKey: "serialPortPath",value: portPath)
    }
    
    
    func get_fileDirectory(inout coreDataObject:dataCore)->String{
        /*
         
         
         
         */
        var fileDirectory = coreDataObject.getSingleObjectAttrib("User_Attrib", nameOfKey: "pathToSaveWS")
        return fileDirectory
    }
    
    
    
    
    func get_serialPort(inout coreDataObject:dataCore)->String{
        /*
         
         
         
         */
        var serialPort = coreDataObject.getSingleObjectAttrib("User_Attrib", nameOfKey: "serialPortPath")
        return serialPort
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}