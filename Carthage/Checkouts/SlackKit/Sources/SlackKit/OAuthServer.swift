//
// OAuthServer.swift
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

import Foundation
import Swifter

internal protocol OAuthDelegate {
    func userAuthed(_ response: OAuthResponse)
}

public struct OAuthServer {
    
    private let oauthURL = "https://slack.com/oauth/authorize"
    
    private let http = HttpServer()
    private let clientID: String
    private let clientSecret: String
    private let state: String?
    private let redirectURI: String?
    private var delegate: OAuthDelegate?
    
    internal init(clientID: String, clientSecret: String, state: String? = nil, redirectURI: String? = nil, port:in_port_t = 8080, forceIPV4: Bool = false, delegate: OAuthDelegate? = nil) throws {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.state = state ?? "state"
        self.redirectURI = redirectURI
        self.delegate = delegate
        oauthRoute()
        start(port, forceIPV4: forceIPV4)
    }
    
    public func start(_ port: in_port_t = 8080, forceIPV4: Bool = false) {
        do {
            try http.start(port, forceIPv4: forceIPV4)
        } catch let error as NSError {
            print("Server failed to start with error: \(error)")
        }
    }
    
    public func stop() {
        http.stop()
    }
    
    private func oauthRoute() {
        http["/oauth"] = { request in
            guard let response = AuthorizeResponse(queryParameters: request.queryParams), response.state == self.state else {
                return .badRequest(.text("Bad request."))
            }
            WebAPI.oauthAccess(clientID: self.clientID, clientSecret: self.clientSecret, code: response.code, redirectURI: self.redirectURI, success: {(response) in
                self.delegate?.userAuthed(OAuthResponse(response: response))
            }, failure: {(error) in
                print("Authorization failed")
            })
            if let redirect = self.redirectURI {
                return .movedPermanently(redirect)
            }
            return .ok(.text("Authentication successful."))
        }
    }
    
    private func oauthURLRequest(_ authorize: AuthorizeRequest) -> URLRequest? {
        var components = URLComponents(string: "\(oauthURL)")
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: "\(authorize.clientID)"),
            URLQueryItem(name: "scope", value: "\(authorize.scope)"),
        ]
        guard let url = components?.url else {
            return nil
        }
        return URLRequest(url: url)
    }
    
    public func authorizeRequest(_ scope:[Scope], redirectURI: String, state: String = "slackkit", team: String? = nil) -> URLRequest? {
        let request = AuthorizeRequest(clientID: clientID, scope: scope, redirectURI: redirectURI, state: state, team: team)
        return oauthURLRequest(request)
    }
}
