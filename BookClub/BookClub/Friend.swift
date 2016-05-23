//
//  User.swift
//  LetterMeApp
//
//  Created by Alex Paul on 10/3/15.
//  Copyright (c) 2015 SWARM NYC. All rights reserved.
//

import UIKit
import Foundation
//import APAddressBook

class Friend: NSObject{

//    static let REQUEST_FROM_USER = "requiring"
//    static let REQUEST_FROM_FRIEND = "accepting"
//    static let LETTERME_FRIEND = "friend"
//    static let STATE_STRANGER = "stranger"
//    static let BLOCKED_FRIEND = "blocked"
//
//    var id: String?
//    var username: String?
//    var displayName: String?
//    var customFont: Bool?
//    var image: Bool?
//    var state: String?
//    var email: String?
//    var phone: String?
//    var updatedAt: NSDate?
//    var addedAt: NSDate?
//    var answeredAt: NSDate?
//    // Font Display Preferences
//    var kern : Int?
//    var lineSpace : Int?
//    var screenWidth : CGFloat?
//
//    var userImage : UIImage?
//
//    var hasImage: Bool {
//        get {
//            return nil != image && image!
//        }
//    }
//    
//    var fontURL: String?{
//        if User.current == nil {
//            return nil
//        }
//        return (customFont != nil && customFont!) ? Constants.SERVER + "/api/font/\(username!)?token=" + User.current!.token! : nil
//    }
//
//    var imageURL: String?{
//        if User.current == nil {
//            return nil
//        }
//        let stamp = updatedAt == nil ? 0 : updatedAt!.timeIntervalSince1970;
//        return (image != nil && image!) ? Constants.SERVER + "/api/user/image/\(username!)?token=\(User.current!.token!)&stamp=\(stamp)" : nil
//    }
//
//    var isApproved : Bool{
//        get {
//            return Friend.LETTERME_FRIEND == state
//            //return Friend.LETTERME_FRIEND == state
//        }
//    }
//
//    var isBlocked : Bool{
//        get {
//            return Friend.BLOCKED_FRIEND == state
//        }
//    }
//
//    var isFriendRequest : Bool{
//        get {
//            return Friend.REQUEST_FROM_FRIEND == state
//        }
//    }
//
//    var sendNotificationMessage: Bool = true
//
//
//    init(_ dict: [String:AnyObject]) {
//        id = dict["_id"] as? String
//        username = dict["username"] as? String
//        displayName = dict["displayName"] as? String
//        email = dict["email"] as? String
//        phone = dict["phone"] as? String
//        image = dict["image"] as? Bool
//        customFont = dict["customFont"] as? Bool
//        state = dict["state"] as? String
//        kern =  dict["kern"] as? Int
//        lineSpace = dict["lineSpace"] as? Int
//        screenWidth = dict["screenWidth"] as? CGFloat
//        
//        if dict["updatedAt"] != nil{
//            updatedAt = NSDate(timeIntervalSince1970: dict["updatedAt"] as! Double)
//        }
//        
//        if dict["addedAt"] != nil{
//            addedAt = NSDate(timeIntervalSince1970: dict["addedAt"] as! Double)
//        }
//        
//        if dict["answeredAt"] != nil{
//            answeredAt = NSDate(timeIntervalSince1970: dict["answeredAt"] as! Double)
//        }
//
//        if kern == nil {
//            kern = Int(1)
//        }
//        
//        if lineSpace == nil {
//            lineSpace = Int(0)
//        }
//        
//        if screenWidth == nil {
//            screenWidth = CGFloat(320.0)
//        }
//
//        if dict[User.USERKEYS.NOTIFICATION_MESSAGE] != nil {
//            sendNotificationMessage = dict[User.USERKEYS.NOTIFICATION_MESSAGE] as! Bool
//        }
//    }
//    
//    init(contact: APContact) {
//        email = contact.emails.first as? String
//        phone = contact.phones.first as? String
//        displayName = ContactHelper.getNameOfContact(contact)
//    }
//    
//    required init?(coder unarchiver: NSCoder) {
//        id = unarchiver.decodeObjectForKey("id") as? String
//        username = unarchiver.decodeObjectForKey("username") as? String
//        displayName = unarchiver.decodeObjectForKey("displayName") as? String
//        customFont = unarchiver.decodeObjectForKey("customFont") as? Bool
//        image = unarchiver.decodeObjectForKey("image") as? Bool
//        state = unarchiver.decodeObjectForKey("state") as? String
//        email = unarchiver.decodeObjectForKey("email") as? String
//        phone = unarchiver.decodeObjectForKey("phone") as? String
//        updatedAt = unarchiver.decodeObjectForKey("updatedAt") as? NSDate
//        addedAt = unarchiver.decodeObjectForKey("addedAt") as? NSDate
//        answeredAt = unarchiver.decodeObjectForKey("answeredAt") as? NSDate
//        
//        kern = unarchiver.decodeObjectForKey("kern") as? Int
//        lineSpace = unarchiver.decodeObjectForKey("lineSpace") as? Int
//        screenWidth = unarchiver.decodeObjectForKey("screenWidth") as? CGFloat
//
//        if kern == nil {
//            kern = Int(1)
//        }
//        if lineSpace == nil {
//            lineSpace = Int(0)
//        }
//        if screenWidth == nil {
//            screenWidth = CGFloat(320.0)
//        }
//
//        if let on = unarchiver.decodeObjectForKey(User.USERKEYS.NOTIFICATION_MESSAGE) as? Bool{
//            sendNotificationMessage = on;
//        }
//    }
//    
//    func encodeWithCoder(archiver: NSCoder) {
//        archiver.encodeObject(id, forKey: "id")
//        archiver.encodeObject(username, forKey: "username")
//        archiver.encodeObject(displayName, forKey: "displayName")
//        archiver.encodeObject(customFont, forKey: "customFont")
//        archiver.encodeObject(image, forKey: "image")
//        archiver.encodeObject(updatedAt, forKey: "updatedAt")
//        archiver.encodeObject(addedAt, forKey: "addedAt")
//        archiver.encodeObject(answeredAt, forKey: "answeredAt")
//        archiver.encodeObject(kern, forKey: "kern")
//        archiver.encodeObject(lineSpace, forKey: "lineSpace")
//        archiver.encodeObject(state, forKey: "state")
//        archiver.encodeObject(screenWidth, forKey: "screenWidth")
//        archiver.encodeObject(email, forKey: "email")
//        archiver.encodeObject(phone, forKey: "phone")
//
//        archiver.encodeObject(sendNotificationMessage, forKey: User.USERKEYS.NOTIFICATION_MESSAGE)
//    }
//    func matchesFilter(filter: String) -> Bool{
//        
//        let lowerCaseFilter = filter.lowercaseString
//        
//        return ((username != nil) && username!.lowercaseString.containsString(lowerCaseFilter)) || ((displayName != nil) && displayName!.lowercaseString.containsString(lowerCaseFilter))
//    }
    
}
