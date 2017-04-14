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
    }
    
    @IBAction func useTwilioAction(_ sender: Any) {
        changeTwilio(state: useTwilio.state)

    }
 
    @IBAction func useSlackAction(_ sender: Any) {
        changeSlack(state: useSlack.state)
    }
    
    
    var appSettings : AppSetttngs?
    
    class func loadFromStoryboard() -> PreferencesViewController? {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "PreferencesViewController") as? PreferencesViewController
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(type(of:self)) viewDidLoad")
        title = "Preferences"
        displaySettings()
    }

    override func viewDidDisappear() {
        
    }
    
    private func displaySettings() {
        showUnlocked.state = (appSettings?.alertWhenUnlocked)! ? NSOnState : NSOffState
        useTwilio.state = (appSettings?.useTwilio)! ? NSOnState : NSOffState
        useSlack.state = (appSettings?.useSlack)! ? NSOnState : NSOffState
        changeTwilio(state: useTwilio.state)
        changeSlack(state: useSlack.state)
    }
    
    private func changeTwilio(state: Int) {
        switch state {
        case NSOnState:
            accountSIDField.isEnabled = true
            authTokenField.isEnabled = true
            toNumberField.isEnabled = true
            fromNumberField.isEnabled = true
        case NSOffState:
            accountSIDField.isEnabled = false
            authTokenField.isEnabled = false
            toNumberField.isEnabled = false
            fromNumberField.isEnabled = false
        default:
            fatalError("Invalid display state")
        }
    }

    private func changeSlack(state: Int) {
        switch state {
        case NSOnState:
            slackChannelField.isEnabled = true
            slackApiField.isEnabled = true
        case NSOffState:
            slackChannelField.isEnabled = false
            slackApiField.isEnabled = false
        default:
            fatalError("Invalid display state")
        }
    }

    
    private func updateSettings() {
        
    }
    
}
