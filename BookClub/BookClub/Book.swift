//
//  Book.swift
//  BookClub
//
//  Created by Johann Kerr on 2/28/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import Foundation
import Parse

class Book: PFObject, PFSubclassing{
    
    @NSManaged var title:String
    @NSManaged var subtitle:String
    @NSManaged var descriptionText:String
    @NSManaged var author:String
    @NSManaged var image:String
    @NSManaged var isAdded:Bool
    @NSManaged var user: PFUser
    @NSManaged var forRent:Bool
    @NSManaged var forSale:Bool
    
    class func parseClassName() -> String{
        return "Book"
    }
    
    override class func initialize(){
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken){
            self.registerSubclass()
        }
    }
    
    override class func query() -> PFQuery?{
        let query = PFQuery(className: Book.parseClassName())
        query.includeKey("user")
        query.orderByDescending("createdAt")
        return query
    }
    
    init(title:String, subtitle:String, author:String, descriptionText:String, image:String, isAdded:Bool, user: PFUser){
        super.init()
        self.title = title
        self.subtitle = subtitle
        self.descriptionText = descriptionText
        self.author = author
        self.image = image
        self.isAdded = isAdded
        self.user = user
        
    }
    
    override init(){
        super.init()
    }
    
    
    
}
