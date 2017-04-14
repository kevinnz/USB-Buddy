![SlackKit](https://cloud.githubusercontent.com/assets/8311605/10260893/5ec60f96-694e-11e5-91fd-da6845942201.png)

![Swift Version](https://img.shields.io/badge/Swift-3.1.0-orange.svg) ![Plaforms](https://img.shields.io/badge/Platforms-macOS,iOS,tvOS-lightgrey.svg) ![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg) [![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-brightgreen.svg)](https://cocoapods.org) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage) [![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
## SlackKit: A Swift Slack Client Library
### Description

This is a Slack client library for OS X, iOS, and tvOS written in Swift. It's intended to expose all of the functionality of Slack's [Real Time Messaging API](https://api.slack.com/rtm) as well as the [web APIs](https://api.slack.com/web) that are accessible to [bot users](https://api.slack.com/bot-users). SlackKit also supports Slack’s [OAuth 2.0](https://api.slack.com/docs/oauth) flow including the [Add to Slack](https://api.slack.com/docs/slack-button) and [Sign in with Slack](https://api.slack.com/docs/sign-in-with-slack) buttons, [incoming webhooks](https://api.slack.com/incoming-webhooks), [slash commands](https://api.slack.com/slash-commands), and [message buttons](https://api.slack.com/docs/message-buttons).

This is the **Swift 3** branch of SlackKit. SlackKit also has support for [Swift 2.3](https://github.com/pvzig/SlackKit/tree/swift2.3) and [Linux](https://github.com/pvzig/SlackKit/tree/linux).

#### Building the SlackKit Framework
To build the SlackKit project directly, first build the dependencies using Carthage or CocoaPods. To use the framework in your application, install it in one of the following ways:

### Installation

#### CocoaPods

Add SlackKit to your pod file:
```
use_frameworks!
pod 'SlackKit'
```
and run
```
# Use CocoaPods version >= 1.1.0
pod install
```

#### Carthage

Add SlackKit to your Cartfile:
```
github "pvzig/SlackKit"
```
and run
```
carthage bootstrap
```

Drag the built `SlackKit.framework` into your Xcode project.

#### Swift Package Manager

Add SlackKit to your Package.swift
```swift
import PackageDescription
  
let package = Package(
	dependencies: [
		.Package(url: "https://github.com/pvzig/SlackKit.git", majorVersion: 3)
	]
)
```

Run `swift build` on your application’s main directory.

To use the library in your project import it:
```
import SlackKit
```

### Usage

#### OAuth
Slack has [many different oauth scopes](https://api.slack.com/docs/oauth-scopes) that can be combined in different ways. If your application does not request the proper OAuth scopes, your API calls will fail. 

If you authenticate using OAuth and the Add to Slack or Sign in with Slack buttons this is handled for you.

If you wish to make OAuth requests yourself, you can generate them using the `authorizeRequest` function on `SlackKit`’s `oauth` property:
```swift
func authorizeRequest(scope:[Scope], redirectURI: String, state: String = "slackkit", team: String? = nil)
```

For local development of things like OAuth, slash commands, and message buttons that require connecting over `https`, you may want to use a tool like [ngrok](https://ngrok.com) or [localtunnel](http://localtunnel.me).

#### Incoming Webhooks
After [configuring your incoming webhook in Slack](https://my.slack.com/services/new/incoming-webhook/), initialize IncomingWebhook with the provided URL and use `postMessage` to send messages.
```swift
let incoming = IncomingWebhook(url: "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX")
let message = Response(text: "Hello, World!")
incoming.postMessage(message)
```

#### Slash Commands
After [configuring your slash command in Slack](https://my.slack.com/services/new/slash-commands) (you can also provide slash commands as part of a [Slack App](https://api.slack.com/slack-apps)), initialize a webhook server with the token for the slash command, a configured route, and a response.
```swift
let response = Response(text: "Hello, World!", responseType: .inChannel)
let webhook = WebhookServer(token: "SLASH-COMMAND-TOKEN", route: "hello_world", response: response)
webhook.start()
```
When a user enters that slash command, it will hit your configured route and return the response you specified.

To add additional routes and responses, you can use WebhookServer’s addRoute function:
```swift 
func addRoute(route: String, response: Response)
```

#### Message Buttons
If you are developing a Slack App and are authorizing using OAuth, you can use [message buttons](https://api.slack.com/docs/message-buttons).

To send messages with actions, add them to an attachment:
```swift
let helloAction = Action(name: "hello_world", text: "Hello, World!")
let attachment = Attachment(fallback: "Hello World Attachment", title: "Attachment with an Action Button", callbackID: "helloworld", actions: [helloAction])
```

To act on message actions, initialize an instance of the `MessageActionServer` using your app’s verification token, your specified interactive messages request URL route, and a `MessageActionResponder`:
```swift
let action = Action(name: "hello_world", text: "Hello, World!")
let response = Response(text: "Hello, 🌎!", responseType: .inChannel)
let responder = MessageActionResponder(responses: [(action, response)])
let server = MessageActionServer(token: "SLACK-APP-VERIFICATION-TOKEN", route: "actions", responder: responder)
server.start()
```

#### Bot Users
To deploy a bot user using SlackKit you'll need a bearer token which identifies a single user. You can generate a [full access token or create one using OAuth 2](https://api.slack.com/web).

Initialize a SlackKit instance using your [application’s Client ID and Client Secret](https://api.slack.com/apps) to set up SlackKit for OAuth authorization:
```swift
let bot = SlackKit(clientID: "CLIENT_ID", clientSecret: "CLIENT_SECRET")
```

or use a manually acquired token:
```swift
let bot = SlackKit(withAPIToken: "xoxp-YOUR-SLACK-API-TOKEN")
```

#### Client Connection Options
You can also set options for a ping/pong interval, timeout interval, and automatic reconnection:
```swift
let options = ClientOptions(pingInterval: 2, timeout: 10, reconnect: false)
let bot = SlackKit(clientID: "CLIENT_ID", clientSecret: "CLIENT_SECRET", clientOptions: options)
```

Once connected, the client will begin to consume any messages sent by the Slack RTM API.

#### Web API Methods
SlackKit currently supports the a subset of the Slack Web APIs that are available to bot users:

- api.test
- auth.revoke
- auth.test
- channels.history
- channels.info
- channels.list
- channels.mark
- channels.setPurpose
- channels.setTopic
- chat.delete
- chat.meMessage
- chat.postMessage
- chat.update
- emoji.list
- files.comments.add
- files.comments.edit
- files.comments.delete
- files.delete
- files.info
- files.upload
- groups.close
- groups.history
- groups.info
- groups.list
- groups.mark
- groups.open
- groups.setPurpose
- groups.setTopic
- im.close
- im.history
- im.list
- im.mark
- im.open
- mpim.close
- mpim.history
- mpim.list
- mpim.mark
- mpim.open
- oauth.access
- pins.add
- pins.list
- pins.remove
- reactions.add
- reactions.get
- reactions.list
- reactions.remove
- rtm.start
- stars.add
- stars.remove
- team.info
- users.getPresence
- users.info
- users.list
- users.setActive
- users.setPresence

They can be accessed through a Client object’s `webAPI` property:
```swift
client.webAPI.authenticationTest({(auth) in
	print(auth)
}, failure: {(error) in
	print(error)
})
```

#### Delegate methods

To receive delegate callbacks for events, register an object as the delegate for those events using the `onClientInitalization` block:
```swift
let bot = SlackKit(clientID: clientID, clientSecret: clientSecret)
bot.onClientInitalization = { (client: Client) in
    DispatchQueue.main.async(execute: {
	    client.messageEventsDelegate = self
    })
}
```

Delegate callbacks contain a reference to the Client where the event occurred.

There are a number of delegates that you can set to receive callbacks for certain events.

##### ConnectionEventsDelegate
```swift
connected(_ client: Client)
disconnected(_ client: Client)
connectionFailed(_ client: Client, error: SlackError)
```
##### MessageEventsDelegate
```swift
sent(_ message: Message, client: Client)
received(_ message: Message, client: Client)
changed(_ message: Message, client: Client)
deleted(_ message: Message?, client: Client)
```
##### ChannelEventsDelegate
```swift
userTypingIn(_ channel: Channel, user: User, client: Client)
marked(_ channel: Channel, timestamp: String, client: Client)
created(_ channel: Channel, client: Client)
deleted(_ channel: Channel, client: Client)
renamed(_ channel: Channel, client: Client)
archived(_ channel: Channel, client: Client)
historyChanged(_ channel: Channel, client: Client)
joined(_ channel: Channel, client: Client)
left(_ channel: Channel, client: Client)
```
##### DoNotDisturbEventsDelegate
```swift
updated(_ status: DoNotDisturbStatus, client: Client)
userUpdated(_ status: DoNotDisturbStatus, user: User, client: Client)
```
##### GroupEventsDelegate
```swift
opened(_ group: Channel, client: Client)
```
##### FileEventsDelegate
```swift
processed(_ file: File, client: Client)
madePrivate(_ file: File, client: Client)
deleted(_ file: File, client: Client)
commentAdded(_ file: File, comment: Comment, client: Client)
commentEdited(_ file: File, comment: Comment, client: Client)
commentDeleted(_ file: File, comment: Comment, client: Client)
```
##### PinEventsDelegate
```swift
pinned(_ item: Item, channel: Channel?, client: Client)
unpinned(_ item: Item, channel: Channel?, client: Client)
```
##### StarEventsDelegate
```swift
starred(_ item: Item, starred: Bool, _ client: Client)
```
##### ReactionEventsDelegate
```swift
added(_ reaction: String, item: Item, itemUser: String, client: Client)
removed(_ reaction: String, item: Item, itemUser: String, client: Client)
```
##### SlackEventsDelegate
```swift
preferenceChanged(_ preference: String, value: Any?, client: Client)
userChanged(_ user: User, client: Client)
presenceChanged(_ user: User, presence: String, client: Client)
manualPresenceChanged(_ user: User, presence: String, client: Client)
botEvent(_ bot: Bot, client: Client)
```
##### TeamEventsDelegate
```swift
userJoined(_ user: User, client: Client)
planChanged(_ plan: String, client: Client)
preferencesChanged(_ preference: String, value: Any?, client: Client)
nameChanged(_ name: String, client: Client)
domainChanged(_ domain: String, client: Client)
emailDomainChanged(_ domain: String, client: Client)
emojiChanged(_ client: Client)
```
##### SubteamEventsDelegate
```swift
event(_ userGroup: UserGroup, client: Client)
selfAdded(_ subteamID: String, client: Client)
selfRemoved(_ subteamID: String, client: Client)
```
##### TeamProfileEventsDelegate
```swift
changed(_ profile: CustomProfile, client: Client)
deleted(_ profile: CustomProfile, client: Client)
reordered(_ profile: CustomProfile, client: Client)
```

### Examples
[Check out example applications here.](https://github.com/pvzig/SlackKit-examples)

### Get In Touch
[@pvzig](https://twitter.com/pvzig)

<peter@launchsoft.co>
