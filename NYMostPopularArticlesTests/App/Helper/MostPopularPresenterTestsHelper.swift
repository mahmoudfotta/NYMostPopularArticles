//
//  MostPopularPresenterTestsHelper.swift
//  NYMostPopularArticlesTests
//
//  Created by Mahmoud Abolfotoh on 05/12/2020.
//

import Foundation
@testable import NYMostPopularArticles

class MostPopularControllerMock: MostPopularView {
    var presentArticlesCalled = false
    var presentEmptyCalled = false
    
    func presentArticles(_ articles: [Article]) {
        presentArticlesCalled = true
    }
    
    func presentEmptyView() {
        presentEmptyCalled = true
    }
}

class ArticlesClientErrorMock: ArticlesService {
    func getMostPopularArticles(completion: @escaping (ArticlesResponse?, Error?) -> Void) {
        completion(nil, NSError(domain: "articlesCliientError", code: 500, userInfo: nil))
    }
}

class ArticlesClientSuccessMock: ArticlesService {
    func getMostPopularArticles(completion: @escaping (ArticlesResponse?, Error?) -> Void) {
        let articlesResponse = ArticlesResponse(articles: [])
        completion(articlesResponse, nil)
    }
}
