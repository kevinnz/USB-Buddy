//
//  AppDelegate.swift
//  USB Buddy
//
//  Created by Kevin Alcock on 10/04/17.
//  Copyright © 2017 Katipo Information Security Ltd. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
    let watcher = Watcher()
    let center = DistributedNotificationCenter.default()
    var screenLocked = false
    let twilioService = TwilioService.shared
    
    let slackService = SlackService(settings: SlackServiceSettings())
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
            button.action = #selector(AppDelegate.buttonWasPressed)
        }
        
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Test Slack", action: #selector(AppDelegate.action1(sender:)), keyEquivalent: "s"))
        menu.addItem(NSMenuItem(title: "Test Twilio", action: #selector(AppDelegate.action2(sender:)), keyEquivalent: "t"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit USB Buddy", action: #selector(AppDelegate.terminate(sender:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
        
        loadSettings()
        
        
        watcher.showNote = true
        watcher.useTwilio = true
        watcher.useSlack = true
        watcher.slackbot = slackService
        
        center.addObserver(self, selector: #selector(self.screenIsLocked), name: NSNotification.Name(rawValue: "com.apple.screenIsLocked")  , object: nil)
        center.addObserver(self, selector: #selector(self.screenIsUnlocked), name: NSNotification.Name(rawValue: "com.apple.screenIsUnlocked")  , object: nil)
        // put in creds for Twilio
       
    }
 
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func loadSettings() {
  
        
    }
    
    func buttonWasPressed(sender: AnyObject) {
        // Insert code here
    }
    
    func action1(sender: AnyObject) {
        slackService.runBot(message: "test", theChannel: "usbwatcher")
    }
    
    func action2(sender: AnyObject) {
         twilioService.send("test", message: "message")
    }

    func terminate(sender: AnyObject) {
        NSApplication.shared().terminate(sender)
    }

    func screenIsLocked() {
        print("Screen is locked")
        screenLocked = true
    }
    
    func screenIsUnlocked() {
        print("Screen is Unlocked")
        screenLocked = false
    }
}

