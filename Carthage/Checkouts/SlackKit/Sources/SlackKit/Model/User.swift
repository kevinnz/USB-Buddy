//
// User.swift
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

public struct User {
    
    public struct Profile {
        
        internal(set) public var firstName: String?
        internal(set) public var lastName: String?
        internal(set) public var realName: String?
        internal(set) public var email: String?
        internal(set) public var skype: String?
        internal(set) public var phone: String?
        internal(set) public var image24: String?
        internal(set) public var image32: String?
        internal(set) public var image48: String?
        internal(set) public var image72: String?
        internal(set) public var image192: String?
        internal(set) public var customProfile: CustomProfile?
        
        internal init(profile: [String: Any]?) {
            firstName = profile?["first_name"] as? String
            lastName = profile?["last_name"] as? String
            realName = profile?["real_name"] as? String
            email = profile?["email"] as? String
            skype = profile?["skype"] as? String
            phone = profile?["phone"] as? String
            image24 = profile?["image_24"] as? String
            image32 = profile?["image_32"] as? String
            image48 = profile?["image_48"] as? String
            image72 = profile?["image_72"] as? String
            image192 = profile?["image_192"] as? String
            customProfile = CustomProfile(customFields: profile?["fields"] as? [String: Any])
        }
    }
    
    public let id: String?
    internal(set) public var name: String?
    internal(set) public var deleted: Bool?
    internal(set) public var profile: Profile?
    internal(set) public var doNotDisturbStatus: DoNotDisturbStatus?
    internal(set) public var presence: String?
    internal(set) public var color: String?
    public let isBot: Bool?
    internal(set) public var isAdmin: Bool?
    internal(set) public var isOwner: Bool?
    internal(set) public var isPrimaryOwner: Bool?
    internal(set) public var isRestricted: Bool?
    internal(set) public var isUltraRestricted: Bool?
    internal(set) public var has2fa: Bool?
    internal(set) public var hasFiles: Bool?
    internal(set) public var status: String?
    internal(set) public var timeZone: String?
    internal(set) public var timeZoneLabel: String?
    internal(set) public var timeZoneOffSet: Int?
    internal(set) public var preferences: [String: Any]?
    // Client properties
    internal(set) public var userGroups: [String: String]?
    
    internal init(user: [String: Any]?) {
        id = user?["id"] as? String
        name = user?["name"] as? String
        deleted = user?["deleted"] as? Bool
        profile = Profile(profile: user?["profile"] as? [String: Any])
        color = user?["color"] as? String
        isAdmin = user?["is_admin"] as? Bool
        isOwner = user?["is_owner"] as? Bool
        isPrimaryOwner = user?["is_primary_owner"] as? Bool
        isRestricted = user?["is_restricted"] as? Bool
        isUltraRestricted = user?["is_ultra_restricted"] as? Bool
        has2fa = user?["has_2fa"] as? Bool
        hasFiles = user?["has_files"] as? Bool
        isBot = user?["is_bot"] as? Bool
        presence = user?["presence"] as? String
        status = user?["status"] as? String
        timeZone = user?["tz"] as? String
        timeZoneLabel = user?["tz_label"] as? String
        timeZoneOffSet = user?["tz_offset"] as? Int
        preferences = user?["prefs"] as? [String: Any]
    }
    
    internal init(id: String?) {
        self.id = id
        self.isBot = nil
    }
}
