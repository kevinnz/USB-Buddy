//
//  Extensions.swift
//  USB Buddy
//
//  Created by Kevin Alcock on 11/04/17.
//  Copyright © 2017 Katipo Information Security Ltd. All rights reserved.
//

import Foundation

extension String {
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func urlEncode() -> String? {
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@+$,/#[] ").inverted)
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
    }
}
