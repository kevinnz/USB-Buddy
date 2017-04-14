//
// OAuthResponse.swift
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

internal struct OAuthResponse {

    let accessToken: String?
    let scope: [Scope]?
    let userID: String?
    let teamName: String?
    let teamID: String?
    let incomingWebhook: IncomingWebhook?
    let bot: Bot?
    
    init(response: [String: Any]?) {
        accessToken = response?["access_token"] as? String
        scope = (response?["scope"] as? String)?.components(separatedBy: ",").flatMap{Scope(rawValue:$0)}
        userID = response?["user_id"] as? String
        teamName = response?["team_name"] as? String
        teamID = response?["team_id"] as? String
        incomingWebhook = IncomingWebhook(webhook: response?["incoming_webhook"] as? [String: Any])
        bot = Bot(botUser: response?["bot"] as? [String: Any])
    }
    
}
