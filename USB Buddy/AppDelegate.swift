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
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
            button.action = #selector(AppDelegate.buttonWasPressed)
        }
        
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Action 1", action: #selector(AppDelegate.action1(sender:)), keyEquivalent: "e"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit USB Buddy", action: #selector(AppDelegate.terminate(sender:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
        watcher.showNote = true
       
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func buttonWasPressed(sender: AnyObject) {
        let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
        let quoteAuthor = "Mark Twain"
        
        print("\(quoteText) — \(quoteAuthor)")
    }
    
    func action1(sender: AnyObject) {
        print("pressed e")
    }

    func terminate(sender: AnyObject) {
        NSApplication.shared().terminate(sender)
    }

    
}

