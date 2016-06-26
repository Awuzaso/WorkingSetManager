//
//  Serial_Port_Manager_Class.swift
//  test
//
//  Created by Osa on 6/24/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

class SerialPortManager:NSObject,ORSSerialPortDelegate{
    
    
    
    var oldStringVal: NSString = "OldValue"
    
    let serialPortManager = ORSSerialPortManager.sharedSerialPortManager()
    
    
    var serialPort: ORSSerialPort!
   
    // MARK: - Modal Window Variables
    
    var nameOfStoryboard: String!
    
    var nameOfWindowIfUnassociated: String!
    
    var nameOfWindowIfAssociated: String!
    
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    init(pathName:String,in_nameOfStoryBoard: String, in_nameOfWinUnAssoc:String, in_nameOfWinAssoc:String){
        super.init()
        
        nameOfStoryboard = in_nameOfStoryBoard
        nameOfWindowIfAssociated = in_nameOfWinAssoc
        nameOfWindowIfUnassociated = in_nameOfWinUnAssoc
        serialPort = ORSSerialPort(path: "\(pathName)")
        serialPort?.delegate = self
        serialPort!.baudRate = 115200
        serialPort!.numberOfStopBits = 1
        serialPort!.open()
    }
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func get_SerialPorts()->Array<String>{
        var arrayOfPorts_string:[String]!
        var arrayOfPorts = serialPortManager.availablePorts
        
       
        
        for(var i = 0; i < arrayOfPorts.count; i++){
            print(arrayOfPorts[i])
            var value = "\(arrayOfPorts[i])"
            
            arrayOfPorts_string[i] = value
        }
        
        
  
        return arrayOfPorts_string
    }
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func launchWindow(nameOfWindow:String){
        
        // 1
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let openWindowController = storyboard.instantiateControllerWithIdentifier(nameOfWindow) as! NSWindowController
        ///*
        // 2
        if let openModalWindow = openWindowController.window{
            
            // 3
            let application = NSApplication.sharedApplication()
            application.runModalForWindow(openModalWindow)
            
        }
        //*/
        
    }
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func giveIDtoAppDelegate(cardValue:String){
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.set_CardValue(cardValue)
    }
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func evaluateIfCardIsInDataBase(cardValue:String)->Bool{
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        
        let dataCore = appDelegate.coreDataObject
        let in_cardValue = cardValue
        
        let retVal = dataCore.evaluateIfInDB("Working_Set", nameOfKey: "tagID", nameOfObject: in_cardValue)
        
        return retVal
    }

    // MARK: - ORSSerialPortDelegate
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func serialPortWasOpened(serialPort: ORSSerialPort) {
        print("Open!")
    }
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func serialPortWasClosed(serialPort: ORSSerialPort) {
        print("Closed!")
    }
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func serialPort(serialPort: ORSSerialPort, didReceiveData data: NSData) {
            // - 1
            print("Active...")
            // -2
        
       
        
            if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                // -3
                if((string.length == 21) && (string != oldStringVal)){
                    // -4
                    oldStringVal = string
                    let sendVal = string as String
                    giveIDtoAppDelegate(sendVal)
                    //var cleanString = oldStringVal - "\r\n"
                    let eval = evaluateIfCardIsInDataBase(string as String)
                    
                    
                    print("It is \(eval) that the card is in the database.")
                    if( eval == false){
                        print("Unassociated")
                        launchWindow(nameOfWindowIfUnassociated)
                        
                    }
                    else if( eval == true){
                        print("Associated")
                        launchWindow(nameOfWindowIfAssociated)
                    }
                    
                }
            }
    }
    
    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func serialPortWasRemovedFromSystem(serialPort: ORSSerialPort) {
        print("Serial port, \(serialPort) was removed from the system.")
    }
    

    /*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
    func serialPort(serialPort: ORSSerialPort, didEncounterError error: NSError) {
        print("Serial port, \(error) was removed from the system.")
        
    }
/*END OF CLASS*/

}