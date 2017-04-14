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
    let appSettings = AppSetttngs.shared
    
    
    var windowController : NSWindowController?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "USBImage")
            button.action = #selector(AppDelegate.buttonWasPressed)
        }
        
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Preferences", action: #selector(AppDelegate.showPreferences(sender:)), keyEquivalent: "p"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit USB Buddy", action: #selector(AppDelegate.terminate(sender:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
        
        watcher.slackbot = slackService
        
        center.addObserver(self, selector: #selector(self.screenIsLocked), name: NSNotification.Name(rawValue: "com.apple.screenIsLocked")  , object: nil)
        center.addObserver(self, selector: #selector(self.screenIsUnlocked), name: NSNotification.Name(rawValue: "com.apple.screenIsUnlocked")  , object: nil)
        
       
    }
 
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func loadSettings() {
  
        
    }
    
    func buttonWasPressed(sender: AnyObject) {
        // Insert code here
    }
    
    func showPreferences(sender: AnyObject) {
     
        let storyboard = NSStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "PreferencesViewController") as! PreferencesViewController
       
        let myWindow = NSWindow(contentViewController: vc )
        myWindow.styleMask = [ .closable, .titled]
        myWindow.makeKeyAndOrderFront(self)
        windowController = NSWindowController(window: myWindow)
        windowController?.showWindow(self)
        
    }
    
    func terminate(sender: AnyObject) {
        NSApplication.shared().terminate(sender)
    }

    func screenIsLocked() {
        watcher.screenLocked = true
    }
    
    func screenIsUnlocked() {
        watcher.screenLocked = false
    }
}

