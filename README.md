# USB Buddy

![Swift Version](https://img.shields.io/badge/Swift-3.1.0-orange.svg) 
![Plaforms](https://img.shields.io/badge/Platforms-macOS-lightgrey.svg) 
![License Apache 2.0](https://img.shields.io/badge/license-Apache--2.0-blue.svg)

USB Buddy is a MacOS tool that monitors USB devices. In the case it detects someone plugging in or unplugging devices it can be configured to send you an SMS 
or alert you via Slack of the potential security breach. I have based this tool off https://github.com/probablynotablog/usb-canary thanks [errbufferoverfl](https://github.com/errbufferoverfl)

## About the Project

I'm not a real hacker and INSERT JOKE ABOUT The Year of Linux on the desktop. I run MacOS Seria and the port of USB Carany to Mac is not yet complete. 
I can write a bit of code and have always want to create a native Mac Application.  

### Why are you using 3rd party libraries?

While I created the integration to Twilio, I got lazy and integrated SlackKit. You can find all you need to know about it here https://github.com/pvzig/SlackKit

## Getting Started

Clone, compile and run.

### Installing

If you don't have XCode then you are in luck. I have compiled the latest version which you can find [here](Install/USBBuddyInstall.dmg)

## Deployment
The following will outline the basic steps to deploying USB Canary to Slack and Twilio. As extra services are 
added, please ensure you add appropriate documentation with your PR.

### Twilio
To use the Twilio intergration you will need to get an:
- [Auth Token](https://support.twilio.com/hc/en-us/articles/223136027-Auth-Tokens-and-how-to-change-them)
- [Account SID](https://support.twilio.com/hc/en-us/articles/223136607-What-is-an-Application-SID-)
- Twilio Mobile Number with SMS support

### Slack
To use the Slack integration you will need to [setup a bot user](https://api.slack.com/bot-users)

## Known Issues

 - No Error reporting, if something has gone wrong chances are you will not know. 
 - Sometimes preferences don't get loaded again after opening the preferences screen twice 

## Authors

- **kevinnz** - *Initial work* - Someone without an original idea

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE.txt](LICENSE.txt) file for details.

## Acknowledgements

- [errbufferoverfl](https://github.com/errbufferoverfl) - for creating `USB Canary`

## Get In Touch
[@kevinnz](https://twitter.com/kevinnz)
