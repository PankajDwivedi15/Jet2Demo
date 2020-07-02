//
//  ArticleDetail+CoreDataProperties.swift
//  
//
//  Created by MacHD on 01/07/20.
//
//

import Foundation
import CoreData


extension ArticleDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleDetail> {
        return NSFetchRequest<ArticleDetail>(entityName: "ArticleDetail")
    }

    @NSManaged public var articleId: String?
    @NSManaged public var articleCreatedAt: String?
    @NSManaged public var articleContent: String?
    @NSManaged public var likes: String?
    @NSManaged public var comments: String?
    @NSManaged public var mediaId: String?
    @NSManaged public var mediaBlogId: String?
    @NSManaged public var mediaCreatedId: String?
    @NSManaged public var mediaImage: String?
    @NSManaged public var mediaTitle: String?
    @NSManaged public var mediaUrl: String?
    @NSManaged public var userId: String?
    @NSManaged public var userBlodId: String?
    @NSManaged public var userCreatedAt: String?
    @NSManaged public var userName: String?
    @NSManaged public var userAvatar: String?
    @NSManaged public var userLastname: String?
    @NSManaged public var userCity: String?
    @NSManaged public var userDesignation: String?
    @NSManaged public var userAbout: String?

}
