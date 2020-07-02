//
//  ArticleListVC.swift
//  Jet2Demo
//
//  Created by MacHD on 01/07/20.
//  Copyright © 2020 organisation. All rights reserved.
//

import UIKit

class ArticleListVC: UIViewController {

    @IBOutlet weak var tblArticleList: UITableView!
    var arrList = [ArticleDetail]()
    var page = 0
    
    let viewModel = ArticleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewModel.delegate = self
        
        // If Stored Data as Locally
        let arrArticles = PersistenceManager.shared.fetch(ArticleDetail.self)
        if arrArticles.count > 40 {
            arrList = arrArticles
            tblArticleList.reloadData()
        }
        
    }
    
    /* Comman method to call the web service */
    func setTheArticle(pageNo:Int) {
        if Manager.sharedInstance.isNetworkConnected(self) {
            viewModel.getTheListOfArticles(page: pageNo + 1)
        }
        else {
            Manager.sharedInstance.showAlert(self, message: AlertMsg.Some_IssueInternet.rawValue)
        }
    }
}

//MARK:-  ------- Table View Delegate ------
extension ArticleListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* To show the loader cell*/
        if indexPath.row == arrList.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifierLoader)as! ArticleCell
            setTheArticle(pageNo: page)
            
            return cell
        }
        else {
            /* To show the cell with Article */
            let article = arrList[indexPath.row]
            if article.mediaId != "" {
                let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier)as! ArticleCell
                cell.setTheCell(detail: article)
                cell.btnArticleUrl.tag = indexPath.row
                cell.btnArticleUrl.addTarget(self, action: #selector(gotoBrowser(sender:)), for: .touchUpInside)
                
                cell.selectionStyle = .none
                return cell
            }
            else {
                /* To show cell without Media detail */
                let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifierNotMedia)as! ArticleCell
                cell.setTheNotMediaCell(detail: article)
                
                cell.selectionStyle = .none
                return cell
            }
        }
        
        
    }
    
    @objc func gotoBrowser(sender:UIButton) {
        
        
        guard let url = URL(string: arrList[sender.tag].mediaUrl ?? "") else { return }
        UIApplication.shared.open(url)
    }
    
}

//MARK:- ------- Model View Delegate ------
extension ArticleListVC: ArticleViewModelDelegate {
    func gotListOfArticle(pageCount:Int, list:[ArticleDetail]){
        if page != pageCount {
            page = pageCount
            for item in list {
                arrList.append(item)
            }
        }
        
        tblArticleList.reloadData()
    }
    
    func failure(pageCount:Int, msg:String){
        Manager.sharedInstance.showAlert(self, message: msg)
    }
}
