//
//  SlackService.swift
//  USB Buddy
//
//  Created by Kevin Alcock on 13/04/17.
//  Copyright © 2017 Katipo Information Security Ltd. All rights reserved.
//

import Foundation
import SlackKit



class SlackService: MessageEventsDelegate {

    var settings : SlackServiceSettings?
    
    
    let bot: SlackKit
    
    init(settings: SlackServiceSettings) {
        bot = SlackKit(withAPIToken: settings.apiToken)
        bot.onClientInitalization = { (client: Client) in
            DispatchQueue.main.async(execute: {
                client.messageEventsDelegate = self
            })
        }
    }
    
    // MARK: MessageEventsDelegate
    func received(_ message: Message, client: Client) {}
    func sent(_ message: Message, client: Client) {}
    func changed(_ message: Message, client: Client) {}
    func deleted(_ message: Message?, client: Client) {}
    
    func runBot(message: String, theChannel: String) {
        bot.clients.forEach { (key: String, client: Client) in
            do {
                let channelID = try client.getChannelIDWith(name: theChannel)
                client.send(message: message, channelID: channelID)
            } catch {
                print(error as NSError)
            }
        }
    }
    
}
