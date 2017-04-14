//
//  TwilioService.swift
//  USB Buddy
//
//  Created by Kevin Alcock on 11/04/17.
//  Copyright © 2017 Katipo Information Security Ltd. All rights reserved.
//

import Foundation



class TwilioService {
    static let shared = TwilioService()

    
    func send(_ title: String, message: String) {
        let appSettings = AppSetttngs.shared
        guard let accountSID = appSettings.twilioSettings?.accountSID,
            let authToken = appSettings.twilioSettings?.authToken,
            let toNumber = appSettings.twilioSettings?.toNumber,
            let fromNumber = appSettings.twilioSettings?.fromNumber else { return }
        
        let endpoint = "https://api.twilio.com/2010-04-01/Accounts/\(accountSID)/Messages.json"
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let tokenString = "\(accountSID):\(authToken)".base64Encoded() ?? ""
        urlRequest.addValue("Basic \(tokenString)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postString = "To=\(toNumber)&From=\(fromNumber)&Body=USB Buddy - \(title): \(message)"
        urlRequest.httpBody = postString.urlEncode()!.data(using: .utf8)
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error=\(error!)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, (httpStatus.statusCode != 200 || httpStatus.statusCode != 201) {
                // check for http errors
                print("statusCode should be 200 or 201, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")        }
        task.resume()
    }
    
}
