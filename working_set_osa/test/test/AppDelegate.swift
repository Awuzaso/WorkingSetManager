//
//  AppDelegate.swift
//  test
//
//  Created by Osa on 6/20/16.
//  Copyright © 2016 Osa. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, ORSSerialPortDelegate {

    
    let serialPortManager = ORSSerialPortManager.sharedSerialPortManager()
    let availableBaudRates = [300, 1200, 2400, 4800, 9600, 14400, 19200, 28800, 38400, 57600, 115200, 230400]
    
    /*var serialPort: ORSSerialPort? {
        didSet {
            oldValue?.close()
            oldValue?.delegate = nil
            serialPort?.delegate = self
        }
    }*/
    
    var serialPort = ORSSerialPort(path: "/dev/cu.usbmodem1411")

    //@IBOutlet weak var sendTextField: NSTextField!
    //@IBOutlet var receivedDataTextView: NSTextView!
    //@IBOutlet weak var openCloseButton: NSButton!
    //@IBOutlet weak var lineEndingPopUpButton: NSPopUpButton!
    
    /*var serialPort: ORSSerialPort? {
         didSet {
            oldValue?.open()
            oldValue?.delegate = nil
            serialPort?.delegate = self
         }
     }*/
    override init() {
        super.init()
        
        print(serialPortManager.availablePorts)
        
        //let port = serialPort(path: )
        
        serialPort?.delegate = self
        serialPort!.baudRate = 115200
        serialPort!.open()
        print("Starting")
        //let nc = NSNotificationCenter.defaultCenter()
        //nc.addObserver(self, selector: "serialPortsWereConnected:", name: ORSSerialPortsWereConnectedNotification, object: nil)
       // nc.addObserver(self, selector: "serialPortsWereDisconnected:", name: ORSSerialPortsWereDisconnectedNotification, object: nil)
       
        //NSUserNotificationCenter.defaultUserNotificationCenter().delegate = self
    }
    
    deinit {
       // NSNotificationCenter.defaultCenter().removeObserver(self)
        serialPort!.close()
    }

  
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        //serialPort = ORSSerialPort(path: "/dev/cu.KeySerial1")!
        //serialPort.baudRate = 4800
        //serialPort.open()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
       
    }
    
    // MARK: - ORSSerialPortDelegate
    
    
    func serialPortWasOpened(serialPort: ORSSerialPort) {
        //self.openCloseButton.title = "Close"
        print("Open!")
    }
    
    func serialPortWasClosed(serialPort: ORSSerialPort) {
        //self.openCloseButton.title = "Open"
    }
    
    func serialPort(serialPort: ORSSerialPort, didReceiveData data: NSData) {
        
         if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
            //self.receivedDataTextView.textStorage?.mutableString.appendString(string as String)
            //self.receivedDataTextView.needsDisplay = true
            print(string)
            print("!!!!!!!!")
            // 1
            let storyboard = NSStoryboard(name: "Main", bundle: nil)
            let openWindowController = storyboard.instantiateControllerWithIdentifier("Test Modal") as! NSWindowController
            
            if let openTestModalWindow = openWindowController.window{
                
                
                let openTestModalWindowController = openTestModalWindow.contentViewController as! testModal
                openTestModalWindowController.testModalLabel.stringValue = string as String
                
                
                
                // 3
                let application = NSApplication.sharedApplication()
                application.runModalForWindow(openTestModalWindow)
            }
            ///////////////
        }
        
        
    }
    
    func serialPortWasRemovedFromSystem(serialPort: ORSSerialPort) {
        
        //elf.serialPort = nil
        //self.openCloseButton.title = "Open"
 
    }
    
    func serialPort(serialPort: ORSSerialPort, didEncounterError error: NSError) {
        
        //print("SerialPort \(serialPort) encountered an error: \(error)")
 
    }
    
 
   

    
    
    
    
    
    
    
    

    
    
    
}

