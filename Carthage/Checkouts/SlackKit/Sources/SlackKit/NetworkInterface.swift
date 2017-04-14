//
// NetworkInterface.swift
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

internal struct NetworkInterface {
    
    private let apiUrl = "https://slack.com/api/"
    
    internal func request(_ endpoint: Endpoint, parameters: [String: Any?], successClosure: @escaping ([String: Any])->Void, errorClosure: @escaping (SlackError)->Void) {
        var components = URLComponents(string: "\(apiUrl)\(endpoint.rawValue)")
        if parameters.count > 0 {
            components?.queryItems = filterNilParameters(parameters).map { URLQueryItem(name: $0.0, value: "\($0.1)") }
        }
        guard let url = components?.url else {
            errorClosure(SlackError.clientNetworkError)
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {(data, response, internalError) in
            do {
                successClosure(try self.handleResponse(data, response: response, internalError: internalError))
            } catch let error {
                errorClosure(error as? SlackError ?? SlackError.unknownError)
            }
        }.resume()
    }
    
    internal func customRequest(_ url: String, data: Data, success: @escaping (Bool)->Void, errorClosure: @escaping (SlackError)->Void) {
        guard let string = url.removingPercentEncoding, let url =  URL(string: string) else {
            errorClosure(SlackError.clientNetworkError)
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        let contentType = "application/json"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) {(data, response, internalError) in
            if internalError == nil {
                success(true)
            } else {
                errorClosure(SlackError.clientNetworkError)
            }
        }.resume()
    }
    
    internal func uploadRequest(data: Data, parameters: [String: Any?], successClosure: @escaping ([String: Any])->Void, errorClosure: @escaping (SlackError)->Void) {
        var components = URLComponents(string: "\(apiUrl)\(Endpoint.filesUpload.rawValue)")
        if parameters.count > 0 {
            components?.queryItems = filterNilParameters(parameters).map { URLQueryItem(name: $0.0, value: "\($0.1)") }
        }
        guard let url = components?.url, let filename = parameters["filename"] as? String, let filetype = parameters["filetype"] as? String else {
            errorClosure(SlackError.clientNetworkError)
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        let boundaryConstant = randomBoundary()
        let contentType = "multipart/form-data; boundary=" + boundaryConstant
        let boundaryStart = "--\(boundaryConstant)\r\n"
        let boundaryEnd = "--\(boundaryConstant)--\r\n"
        let contentDispositionString = "Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n"
        let contentTypeString = "Content-Type: \(filetype)\r\n\r\n"
        
        var requestBodyData: Data = Data()
        requestBodyData.append(boundaryStart.data(using: String.Encoding.utf8)!)
        requestBodyData.append(contentDispositionString.data(using: String.Encoding.utf8)!)
        requestBodyData.append(contentTypeString.data(using: String.Encoding.utf8)!)
        requestBodyData.append(data)
        requestBodyData.append("\r\n".data(using: String.Encoding.utf8)!)
        requestBodyData.append(boundaryEnd.data(using: String.Encoding.utf8)!)
        
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpBody = requestBodyData as Data
        
        URLSession.shared.dataTask(with: request) {(data, response, internalError) in
            do {
                successClosure(try self.handleResponse(data, response: response, internalError: internalError))
            } catch let error {
                errorClosure(error as? SlackError ?? SlackError.unknownError)
            }
        }.resume()
    }
    
    private func handleResponse(_ data: Data?, response:URLResponse?, internalError:Error?) throws -> [String: Any] {
        guard let data = data, let response = response as? HTTPURLResponse else {
            throw SlackError.clientNetworkError
        }
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                throw SlackError.clientJSONError
            }
            
            switch response.statusCode {
            case 200:
                if (json["ok"] as! Bool == true) {
                    return json
                } else {
                    if let errorString = json["error"] as? String {
                        throw SlackError(rawValue: errorString) ?? .unknownError
                    } else {
                        throw SlackError.unknownError
                    }
                }
            case 429:
                throw SlackError.tooManyRequests
            default:
                throw SlackError.clientNetworkError
            }
        } catch let error {
            if let slackError = error as? SlackError {
                throw slackError
            } else {
                throw SlackError.unknownError
            }
        }
    }
    
    private func randomBoundary() -> String {
        return String(format: "slackkit.boundary.%08x%08x", arc4random(), arc4random())
    }
    
    //MARK: - Filter Nil Parameters
    private func filterNilParameters(_ parameters: [String: Any?]) -> [String: Any] {
        var finalParameters = [String: Any]()
        for (key, value) in parameters {
            if let unwrapped = value {
                finalParameters[key] = unwrapped
            }
        }
        return finalParameters
    }
}
