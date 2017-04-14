//
//  PreferencesViewController.swift
//  USB Buddy
//
//  Created by Kevin Alcock on 14/04/17.
//  Copyright © 2017 Katipo Information Security Ltd. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSViewController {
    
    // outlets
    
    @IBOutlet var showUnlocked: NSButton!
    @IBOutlet var useTwilio: NSButton!
    @IBOutlet var useSlack: NSButton!
    @IBOutlet var accountSIDField: NSTextField!
    @IBOutlet var authTokenField: NSTextField!
    @IBOutlet var fromNumberField: NSTextField!
    @IBOutlet var toNumberField: NSTextField!
    @IBOutlet var slackChannelField: NSTextField!
    @IBOutlet var slackApiField: NSTextField!
    
    // actions
    @IBAction func alertUnlockedAction(_ sender: Any) {
        if showUnlocked.state == NSOnState {
            appSettings.alertWhenUnlocked = true
        } else {
            appSettings.alertWhenUnlocked = false
        }
    }
    
    @IBAction func useTwilioAction(_ sender: Any) {
        changeTwilio(state: useTwilio.state)

    }
 
    @IBAction func useSlackAction(_ sender: Any) {
        changeSlack(state: useSlack.state)
    }
    
    
    var appSettings : AppSetttngs {
        return AppSetttngs.shared
    }
    
    class func loadFromStoryboard() -> PreferencesViewController? {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "PreferencesViewController") as? PreferencesViewController
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Preferences"
        displaySettings()
    }

    override func viewDidDisappear() {
        updateSettings()
    }
    
    private func displaySettings() {
        showUnlocked.state = appSettings.alertWhenUnlocked ? NSOnState : NSOffState
        useTwilio.state = appSettings.useTwilio ? NSOnState : NSOffState
        useSlack.state = appSettings.useSlack ? NSOnState : NSOffState
        changeTwilio(state: useTwilio.state)
        changeSlack(state: useSlack.state)
        if let twiloSettings = appSettings.twilioSettings {
            accountSIDField.stringValue = twiloSettings.accountSID
            authTokenField.stringValue = twiloSettings.authToken
            toNumberField.stringValue = twiloSettings.toNumber
            fromNumberField.stringValue = twiloSettings.fromNumber
        }
        if let slackSettings = appSettings.slackSettings {
            slackChannelField.stringValue = slackSettings.channel
            slackApiField.stringValue = slackSettings.apiToken
        }
        
    }
    
    private func changeTwilio(state: Int) {
        switch state {
        case NSOnState:
            accountSIDField.isEnabled = true
            authTokenField.isEnabled = true
            toNumberField.isEnabled = true
            fromNumberField.isEnabled = true
            appSettings.useTwilio = true
        case NSOffState:
            accountSIDField.isEnabled = false
            authTokenField.isEnabled = false
            toNumberField.isEnabled = false
            fromNumberField.isEnabled = false
            appSettings.useTwilio = false
        default:
            fatalError("Invalid display state")
        }
    }

    private func changeSlack(state: Int) {
        switch state {
        case NSOnState:
            slackChannelField.isEnabled = true
            slackApiField.isEnabled = true
            appSettings.useSlack = true
        case NSOffState:
            slackChannelField.isEnabled = false
            slackApiField.isEnabled = false
            appSettings.useSlack = false
        default:
            fatalError("Invalid display state")
        }
    }
    
    private func updateSettings() {
        if var twilioSettings = appSettings.twilioSettings {
            twilioSettings.accountSID = accountSIDField.stringValue
            twilioSettings.authToken = authTokenField.stringValue
            twilioSettings.fromNumber = fromNumberField.stringValue
            twilioSettings.toNumber = toNumberField.stringValue
        }
        if var slackSettings = appSettings.slackSettings {
            slackSettings.channel = slackChannelField.stringValue
            slackSettings.apiToken = slackApiField.stringValue
        }
    }
    
}
