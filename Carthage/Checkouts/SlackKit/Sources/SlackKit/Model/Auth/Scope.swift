//
// Scope.swift
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

public enum Scope: String {
    
    case ChannelsHistory = "channels:history"
    case ChannelsRead = "channels:read"
    case ChannelsWrite = "channels:write"
    case ChatWriteBot = "chat:write:bot"
    case ChatWriteUser = "chat:write:user"
    case DNDRead = "dnd:read"
    case DNDWrite = "dnd:write"
    case EmojiRead = "emoji:read"
    case FilesRead = "files:read"
    case FilesWriteUser = "files:write:user"
    case GroupsHistory = "groups:history"
    case GroupsRead = "groups:read"
    case GroupsWrite = "groups:write"
    case IdentityBasic = "identity.basic"
    case IMHistory = "im:history"
    case IMRead = "im:read"
    case IMWrite = "im:write"
    case MPIMHistory = "mpim:history"
    case MPIMRead = "mpim:read"
    case MPIMWrite = "mpim:write"
    case PinsRead = "pins:read"
    case PinsWrite = "pins:write"
    case ReactionsRead = "reactions:read"
    case ReactionsWrite = "reactions:write"
    case RemindersRead = "reminders:read"
    case RemindersWrite = "reminders:write"
    case SearchRead = "search:read"
    case StarsRead = "stars:read"
    case StarsWrite = "stars:write"
    case TeamRead = "team:read"
    case UserGroupsRead = "usergroups:read"
    case UserGroupsWrite = "usergroups:write"
    case UserProfilesRead = "user.profiles:read"
    case UserProfilesWrite = "user.profiles:write"
    case UsersRead = "users:read"
    case UsersWrite = "users:write"
    case IncomingWebhook = "incoming-webhook"
    case Commands = "commands"
    case Bot = "bot"
    case Identify = "identify"
    case Client = "client"
    case Admin = "admin"
    //Deprecated
    case Read = "read"
    case Post = "post"
}
