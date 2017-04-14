//
//  Settings.swift
//  USB Buddy
//
//  Created by Kevin Alcock on 14/04/17.
//  Copyright © 2017 Katipo Information Security Ltd. All rights reserved.
//

import Foundation

struct AppSetttngs {
    var alertWhenUnlocked = false
    var useSlack = false
    var useTwilio = false
    var slackSettings = SlackServiceSettings()
    var twilioSettings = TwilioSettings(accountSID: "", authToken: "", toNumber: "", fromNumber: "")
}

struct TwilioSettings {
    var accountSID : String
    var authToken: String
    var toNumber: String
    var fromNumber: String
    
}

struct SlackServiceSettings {
    private(set) var channel = "usbwatcher"
    private(set) var apiToken = "xoxb-XXXXXXXXXXXXXXXXXXXXXXXXXXX"
    
}

enum SettingsKeys : String {
    case alertWhenUnlocked
    case useTwilio
    case useSlack
    case twilioAccountSID
    case twilioAuthToken
    case twilioToNumber
    case twilioFromNumber
    case slackChannel
    case slackApiToken
}
