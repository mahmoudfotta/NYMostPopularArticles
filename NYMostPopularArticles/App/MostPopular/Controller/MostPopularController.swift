//
//  ViewController.swift
//  NYMostPopularArticles
//
//  Created by Mahmoud Abolfotoh on 04/12/2020.
//

import UIKit

class MostPopularController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var presenter: MostPopularPresenter!
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getArticles()
    }
    
    fileprivate func setupUI() {
        title = "Most Popular"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
    }
    
    func getArticles() {
        presenter = MostPopularPresenter(view: self, articlesClient: ArticlesClient())
        presenter.presentMostPopularArticles()
    }
}

extension MostPopularController: MostPopularView {
    func presentArticles(_ articles: [Article]) {
        self.articles = articles
        tableView.reloadData()
    }
    
    func presentEmptyView() {
        
    }
}

extension MostPopularController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleCell
        let article = articles[indexPath.row]
        articleCell.articleTitleLabel.text = article.title
        articleCell.byLabel.text = article.byline
        articleCell.dateLabel.text = article.publishedDate
        return articleCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
