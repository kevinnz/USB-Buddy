//
// EventDelegate.swift
//
// Copyright © 2016 Peter Zignego. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

public protocol ConnectionEventsDelegate: class {
    func connected(_ client: Client)
    func disconnected(_ client: Client)
    func connectionFailed(_ client: Client, error: SlackError)
}

public protocol MessageEventsDelegate: class {
    func sent(_ message: Message, client: Client)
    func received(_ message: Message, client: Client)
    func changed(_ message: Message, client: Client)
    func deleted(_ message: Message?, client: Client)
}

public protocol ChannelEventsDelegate: class {
    func userTypingIn(_ channel: Channel, user: User, client: Client)
    func marked(_ channel: Channel, timestamp: String, client: Client)
    func created(_ channel: Channel, client: Client)
    func deleted(_ channel: Channel, client: Client)
    func renamed(_ channel: Channel, client: Client)
    func archived(_ channel: Channel, client: Client)
    func historyChanged(_ channel: Channel, client: Client)
    func joined(_ channel: Channel, client: Client)
    func left(_ channel: Channel, client: Client)
}

public protocol DoNotDisturbEventsDelegate: class {
    func updated(_ status: DoNotDisturbStatus, client: Client)
    func userUpdated(_ status: DoNotDisturbStatus, user: User, client: Client)
}

public protocol GroupEventsDelegate: class {
    func opened(_ group: Channel, client: Client)
}

public protocol FileEventsDelegate: class {
    func processed(_ file: File, client: Client)
    func madePrivate(_ file: File, client: Client)
    func deleted(_ file: File, client: Client)
    func commentAdded(_ file: File, comment: Comment, client: Client)
    func commentEdited(_ file: File, comment: Comment, client: Client)
    func commentDeleted(_ file: File, comment: Comment, client: Client)
}

public protocol PinEventsDelegate: class {
    func pinned(_ item: Item, channel: Channel?, client: Client)
    func unpinned(_ item: Item, channel: Channel?, client: Client)
}

public protocol StarEventsDelegate: class {
    func starred(_ item: Item, starred: Bool, _ client: Client)
}

public protocol ReactionEventsDelegate: class {
    func added(_ reaction: String, item: Item, itemUser: String, client: Client)
    func removed(_ reaction: String, item: Item, itemUser: String, client: Client)
}

public protocol SlackEventsDelegate: class {
    func preferenceChanged(_ preference: String, value: Any?, client: Client)
    func userChanged(_ user: User, client: Client)
    func presenceChanged(_ user: User, presence: String, client: Client)
    func manualPresenceChanged(_ user: User, presence: String, client: Client)
    func botEvent(_ bot: Bot, client: Client)
}

public protocol TeamEventsDelegate: class {
    func userJoined(_ user: User, client: Client)
    func planChanged(_ plan: String, client: Client)
    func preferencesChanged(_ preference: String, value: Any?, client: Client)
    func nameChanged(_ name: String, client: Client)
    func domainChanged(_ domain: String, client: Client)
    func emailDomainChanged(_ domain: String, client: Client)
    func emojiChanged(_ client: Client)
}

public protocol SubteamEventsDelegate: class {
    func event(_ userGroup: UserGroup, client: Client)
    func selfAdded(_ subteamID: String, client: Client)
    func selfRemoved(_ subteamID: String, client: Client)
}

public protocol TeamProfileEventsDelegate: class {
    func changed(_ profile: CustomProfile, client: Client)
    func deleted(_ profile: CustomProfile, client: Client)
    func reordered(_ profile: CustomProfile, client: Client)
}
