//
// WebhookServer.swift
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

open class WebhookServer: Server {
    
    public init(token: String, route: String, response: Response) {
        super.init(token: token)
        addRoute(route, response: response)
    }
    
    open func addRoute(_ route: String, response: Response) {
        http["/\(route)"] = { request in
            let webhookRequest = WebhookRequest(request: self.dictionaryFromRequest(request.body))
            if webhookRequest.token == self.token {
                return self.request(webhookRequest, reply: self.replyForResponse(response))
            } else {
                return .badRequest(.text("Bad request."))
            }
        }
    }
    
    private func replyForResponse(_ response: Response) -> Reply {
        if response.attachments == nil && response.responseType == nil {
            return Reply.text(body: response.text)
        } else {
            return Reply.json(response: response)
        }
    }
}
