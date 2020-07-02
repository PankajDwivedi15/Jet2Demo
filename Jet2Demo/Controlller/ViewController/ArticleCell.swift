//
//  ArticleCell.swift
//  Jet2Demo
//
//  Created by MacHD on 01/07/20.
//  Copyright © 2020 organisation. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {
    
    static let identifier = "ArticleCell"
    static let identifierNotMedia = "ArticleNoMediaCell"
    static let identifierLoader = "ArticleLoaderCell"
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var imgMedia: UIImageView!
    
    @IBOutlet weak var lblArticleDescription: UILabel!
    @IBOutlet weak var lblArticleTitle: UILabel!
    @IBOutlet weak var btnArticleUrl: UIButton!
    @IBOutlet weak var btnLikes: UIButton!
    @IBOutlet weak var btnComments: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:-  ---- Media Cell -----
    /* Set up the Media cell */
    func setTheCell(detail:ArticleDetail) {
        
        imgUser.kf.setImage(with: URL.init(string: detail.userAvatar ?? ""))
        lblUsername.text = detail.userName ?? ""
        lblDesignation.text = detail.userDesignation ?? ""
        
        imgMedia.kf.setImage(with: URL.init(string: detail.mediaImage ?? ""))
        lblArticleDescription.text = detail.articleContent ?? ""
        lblArticleTitle.text = detail.mediaTitle ?? ""
        btnArticleUrl.setTitle(detail.mediaUrl ?? "", for: .normal)
        lblTime.text = setTheTime(userTime: detail.articleCreatedAt ?? "")
        
        guard let likes = Int(detail.likes!) else { return }
        guard let comment = Int(detail.comments!) else { return }
        
        
        if likes > 1 {
            let likesCount = likes.roundedWithAbbreviations + " Likes"
            btnLikes.setTitle(likesCount, for: .normal)
        }
        else {
            let likesCount = likes.roundedWithAbbreviations + " Like"
            btnLikes.setTitle(likesCount, for: .normal)
        }
        
        if comment > 1 {
            let commentCount = comment.roundedWithAbbreviations + " Comments"
            btnComments.setTitle(commentCount, for: .normal)
        }
        else {
            let commentCount = comment.roundedWithAbbreviations + " Comment"
            btnComments.setTitle(commentCount, for: .normal)
        }
        
    }
    
    //MARK:-  ---- WithOut Media Cell -----
    /* Set up the without Media cell */
    func setTheNotMediaCell(detail:ArticleDetail) {
        imgUser.kf.setImage(with: URL.init(string: detail.userAvatar ?? ""))
        lblUsername.text = detail.userName ?? ""
        lblDesignation.text = detail.userDesignation ?? ""
        
        lblArticleDescription.text = detail.articleContent
        lblTime.text = setTheTime(userTime: detail.articleCreatedAt ?? "")
    }
    
//    2020-04-17T12:13:44.575Z"
    func setTheTime(userTime:String) -> String {
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateformatter.date(from: userTime)
        
        guard let convertedDate = date?.timeAgoSinceDate() else { return "" }
        
        return convertedDate
    }
    
}
