//
// MessageActionServer.swift
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

open class MessageActionServer: Server {
    
    internal let responder: MessageActionResponder
    
    required public init(token: String, route: String, responder: MessageActionResponder) {
        self.responder = responder
        super.init(token: token)
        addRoute(route)
    }
    
    internal func addRoute(_ route: String) {
        http.POST["/\(route)"] = { request in
            let payload = request.parseUrlencodedForm()
            let actionRequest = MessageActionRequest(response: self.jsonFromRequest(payload[0].1))
            if let reply = self.responder.responseForRequest(actionRequest), actionRequest.token == self.token {
                return self.request(actionRequest, reply: reply)
            } else {
                return .badRequest(.text("Bad request."))
            }
        }
    }
}
