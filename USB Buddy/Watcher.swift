//
//  Watcher.swift
//  USB Buddy
//
//  Created by Kevin Alcock on 10/04/17.
//  Copyright © 2017 Katipo Information Security Ltd. All rights reserved.
//

import AppKit

class Watcher: NSObject, USBWatcherDelegate, NSUserNotificationCenterDelegate {
    
    var showNote = false
    var useTwilio = false
    var useSlack = false
    
    private var usbWatcher: USBWatcher!
    override init() {
        super.init()
        usbWatcher = USBWatcher(delegate: self)
    }
    
    func deviceAdded(_ device: io_object_t) {
        let title = "Device Added"
        let msg = device.name() ?? "<unknown>"
        showNotification(title, message: msg)
    }
    
    func deviceRemoved(_ device: io_object_t) {
        let title = "Device Removed"
        let msg = device.name() ?? "<unknown>"
        showNotification(title, message: msg)
    }
    
    func showNotification(_ title: String, message: String) -> Void {
        
        if showNote {
            localNotification(title, message: message)
        }
        
        if useTwilio {
            sendTwilio(title, message: message)
        }
    }

    func localNotification(_ title: String, message: String) {
        let notification = NSUserNotification()
        
        notification.title = title
        notification.informativeText = message
        notification.contentImage = NSImage(named: "USBImage")
        notification.soundName = NSUserNotificationDefaultSoundName
        
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    func sendTwilio(_ title: String, message: String) {
        TwilioService.shared.send(title, message: message)
    }
    
    func sendSlack(_ title: String, message: String) {
        fatalError("Not implemented")
    }
}
