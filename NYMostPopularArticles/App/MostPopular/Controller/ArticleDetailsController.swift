//
//  ArticleDetailsController.swift
//  NYMostPopularArticles
//
//  Created by Mahmoud Abolfotoh on 04/12/2020.
//

import UIKit

class ArticleDetailsController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        title = article.subsection
        titleLabel.text = article.title
        byLabel.text = article.byline
        dateLabel.text = article.publishedDate
        abstractLabel.text = article.abstract
    }
}
