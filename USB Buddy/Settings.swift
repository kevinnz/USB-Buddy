//
//  Settings.swift
//  USB Buddy
//
//  Created by Kevin Alcock on 14/04/17.
//  Copyright © 2017 Katipo Information Security Ltd. All rights reserved.
//

import Foundation

class AppSetttngs {
    
    private let defaults = UserDefaults.standard
    static let shared = AppSetttngs()
    
    var alertWhenUnlocked: Bool {
        didSet {
            defaults.set(alertWhenUnlocked, forKey: SettingsKeys.alertWhenUnlocked.rawValue)
        }
    }
    var useSlack: Bool {
        didSet {
            defaults.set(useSlack, forKey: SettingsKeys.useSlack.rawValue)
        }
    }
    var useTwilio: Bool {
        didSet {
            defaults.set(useTwilio, forKey: SettingsKeys.useTwilio.rawValue)
        }
    }
    var slackSettings: SlackServiceSettings?
    var twilioSettings: TwilioSettings?
    
    init() {
        alertWhenUnlocked = defaults.bool(forKey: SettingsKeys.alertWhenUnlocked.rawValue)
        useSlack = defaults.bool(forKey: SettingsKeys.useSlack.rawValue)
        useTwilio = defaults.bool(forKey: SettingsKeys.useTwilio.rawValue)
        twilioSettings = TwilioSettings()
        slackSettings = SlackServiceSettings()
    }
}

    

struct TwilioSettings {
    private let defaults = UserDefaults.standard
    
    var accountSID : String {
        didSet {
            defaults.set(accountSID, forKey: SettingsKeys.twilioAccountSID.rawValue)
        }
    }
    var authToken: String {
        didSet {
            defaults.set(authToken, forKey: SettingsKeys.twilioAuthToken.rawValue)
        }
    }
    var toNumber: String {
        didSet {
            defaults.set(toNumber, forKey: SettingsKeys.twilioToNumber.rawValue)
        }
    }
    var fromNumber: String {
        didSet {
            defaults.set(fromNumber, forKey: SettingsKeys.twilioFromNumber.rawValue)
        }
    }
    
    init() {
        accountSID = defaults.string(forKey: SettingsKeys.twilioAccountSID.rawValue) ?? ""
        authToken = defaults.string(forKey: SettingsKeys.twilioAuthToken.rawValue) ?? ""
        toNumber = defaults.string(forKey: SettingsKeys.twilioToNumber.rawValue) ?? ""
        fromNumber = defaults.string(forKey: SettingsKeys.twilioFromNumber.rawValue) ?? ""
    }
    
}

struct SlackServiceSettings {
    private let defaults = UserDefaults.standard

    var channel: String {
        didSet {
            defaults.set(channel, forKey: SettingsKeys.slackChannel.rawValue)
        }
    }
    var apiToken: String {
        didSet {
            defaults.set(apiToken, forKey: SettingsKeys.slackApiToken.rawValue)
        }
    }
    
    init() {
        channel = defaults.string(forKey: SettingsKeys.slackChannel.rawValue) ?? ""
        apiToken = defaults.string(forKey: SettingsKeys.slackApiToken.rawValue) ?? ""
    }
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
