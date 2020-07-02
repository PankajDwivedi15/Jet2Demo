//
//  ArticleModel.swift
//  Jet2Demo
//
//  Created by MacHD on 01/07/20.
//  Copyright © 2020 organisation. All rights reserved.
//

import Foundation

// MARK: - ArticleModelElement
class ArticleModel: Codable {
    let id, createdAt, content: String
    let comments, likes: Int
    let media: [Media]
    let user: [User]

    init(id: String, createdAt: String, content: String, comments: Int, likes: Int, media: [Media], user: [User]) {
        self.id = id
        self.createdAt = createdAt
        self.content = content
        self.comments = comments
        self.likes = likes
        self.media = media
        self.user = user
    }
}

// MARK: - Media
class Media: Codable {
    let id, blogID, createdAt: String
    let image: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case blogID = "blogId"
        case createdAt, image, title, url
    }

    init(id: String, blogID: String, createdAt: String, image: String, title: String, url: String) {
        self.id = id
        self.blogID = blogID
        self.createdAt = createdAt
        self.image = image
        self.title = title
        self.url = url
    }
}

// MARK: - User
class User: Codable {
    let id, blogID, createdAt, name: String
    let avatar: String
    let lastname, city, designation, about: String

    enum CodingKeys: String, CodingKey {
        case id
        case blogID = "blogId"
        case createdAt, name, avatar, lastname, city, designation, about
    }

    init(id: String, blogID: String, createdAt: String, name: String, avatar: String, lastname: String, city: String, designation: String, about: String) {
        self.id = id
        self.blogID = blogID
        self.createdAt = createdAt
        self.name = name
        self.avatar = avatar
        self.lastname = lastname
        self.city = city
        self.designation = designation
        self.about = about
    }
}



class ArticleRequest: Codable {
    let page, limit:String
    
    enum CodingKeys: String, CodingKey {
        case page
        case limit
    }
    
    init(page:Int) {
        self.page = "\(page)"
        self.limit = "10"
    }
}
