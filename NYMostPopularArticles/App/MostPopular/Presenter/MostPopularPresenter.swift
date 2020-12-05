//
//  MostPopularPresenter.swift
//  NYMostPopularArticles
//
//  Created by Mahmoud Abolfotoh on 04/12/2020.
//

import Foundation

class MostPopularPresenter {
    let view: MostPopularView
    let articlesClient: ArticlesService
    
    init(view: MostPopularView, articlesClient: ArticlesService) {
        self.view = view
        self.articlesClient = articlesClient
    }
    
    func presentMostPopularArticles() {
        articlesClient.getMostPopularArticles { [weak self] (response, error) in
            guard let self = self else { return }
            if let response = response {
                self.view.presentArticles(response.articles)
            } else {
                self.view.presentEmptyView()
            }
        }
    }
}
