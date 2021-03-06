//
//  Watcher.swift
//  USB Buddy
//
//  Created by Kevin Alcock on 10/04/17.
//  Copyright © 2017 Katipo Information Security Ltd. All rights reserved.
//

import AppKit

class Watcher: NSObject, USBWatcherDelegate, NSUserNotificationCenterDelegate {
    
    var appSettings: AppSetttngs {
        return AppSetttngs.shared
    }
    var slackbot: SlackService?
    var screenLocked = false
    
    private var showNote: Bool {
        let alert = appSettings.alertWhenUnlocked
        return alert && !screenLocked
    }
    
    private var useTwilio: Bool {
        if appSettings.useTwilio && screenLocked {
            return true
        }
        if appSettings.useTwilio && appSettings.alertWhenUnlocked {
            return true
        }
        return false
    }

    private var useSlack: Bool {
        if appSettings.useSlack && screenLocked {
            return true
        }
        if appSettings.useSlack && appSettings.alertWhenUnlocked {
            return true
        }
        return false
    }

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
        
        if useSlack {
            sendSlack(title, message: message)
        }
    }

    func localNotification(_ title: String, message: String) {
        let notification = NSUserNotification()
        
        notification.title = title
        notification.informativeText = message
        notification.contentImage = NSImage(named: "USBNoteImage")
        notification.soundName = NSUserNotificationDefaultSoundName
        
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    func sendTwilio(_ title: String, message: String) {
        TwilioService.shared.send(title, message: message)
    }
    
    func sendSlack(_ title: String, message: String) {
        let settings = SlackServiceSettings()
        slackbot?.runBot(message: "\(title): \(message)", theChannel: settings.channel)
    }
}
