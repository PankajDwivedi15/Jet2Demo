//
//  ArticleViewModel.swift
//  Jet2Demo
//
//  Created by MacHD on 01/07/20.
//  Copyright © 2020 organisation. All rights reserved.
//

import Foundation


protocol ArticleViewModelDelegate: class {
    func gotListOfArticle(pageCount:Int, list:[ArticleDetail]);
    func failure(pageCount:Int, msg:String);
}

class ArticleViewModel {
    
    weak var delegate:ArticleViewModelDelegate?
    
    func getTheListOfArticles(page:Int) {
//        1&limit=100
        let url = ServiceCall.BlogsPage.rawValue + "\(page)" + ServiceCall.Limit.rawValue
        
        NetworkingClient().request(urlString: url, httpMethod: .get, parameters: ArticleRequest.init(page: page), decodingType: [ArticleModel].self, isGet:true) { (response, msg) in
                                                        
            if (response == nil) {
                self.delegate?.failure(pageCount:page - 1, msg:msg ?? "")
            }
            else if ((response as! [ArticleModel]).count > 0){
                print("Success Response: \(String(describing: response))")
                let arr = response as! [ArticleModel]
                
                /* Here we are storing the server data in the local database */
                for item in arr {
                    let obj = ArticleDetail(context: PersistenceManager.shared.context)
                    obj.articleId = item.id
                    obj.articleCreatedAt = item.createdAt
                    obj.articleContent = item.content
                    obj.likes = item.likes.description
                    obj.comments = item.comments.description
                    
                    // MEDIA
                    if item.media.count > 0 {
                        obj.mediaId = item.media[0].id
                        obj.mediaBlogId = item.media[0].blogID
                        obj.mediaCreatedId = item.media[0].createdAt
                        obj.mediaImage = item.media[0].image
                        obj.mediaTitle = item.media[0].title
                        obj.mediaUrl = item.media[0].url
                    } else {
                        obj.mediaId = ""
                        obj.mediaBlogId = ""
                        obj.mediaCreatedId = ""
                        obj.mediaImage = ""
                        obj.mediaTitle = ""
                        obj.mediaUrl = ""
                    }
                    
                    // USER
                    if item.user.count > 0 {
                        obj.userId = item.user[0].id
                        obj.userBlodId = item.user[0].blogID
                        obj.userCreatedAt = item.user[0].createdAt
                        obj.userName = item.user[0].name
                        obj.userAvatar = item.user[0].avatar
                        obj.userLastname = item.user[0].lastname
                        obj.userCity = item.user[0].city
                        obj.userDesignation = item.user[0].designation
                        obj.userAbout = item.user[0].about
                    }
                    else {
                        obj.userId = ""
                        obj.userBlodId = ""
                        obj.userCreatedAt = ""
                        obj.userName = ""
                        obj.userAvatar = ""
                        obj.userLastname = ""
                        obj.userCity = ""
                        obj.userDesignation = ""
                        obj.userAbout = ""
                    }
                    
                    PersistenceManager.shared.save()
                }
                
                let arrArticles = PersistenceManager.shared.fetch(ArticleDetail.self)
                self.delegate?.gotListOfArticle(pageCount:page, list:arrArticles)
            }
            else {
                self.delegate?.failure(pageCount:page - 1, msg:msg ?? "")
            }
                
            
        }
    }
    
}
