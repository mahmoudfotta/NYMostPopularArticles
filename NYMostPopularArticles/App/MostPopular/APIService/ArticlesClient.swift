//
//  ArticlesClient.swift
//  NYMostPopularArticles
//
//  Created by Mahmoud Abolfotoh on 04/12/2020.
//

import Foundation

protocol ArticlesService {
    func getMostPopularArticles(completion: @escaping (ArticlesResponse?, Error?) -> Void)
}

class ArticlesClient: ArticlesService {
    let remoteService: RemoteService
    let mostPopularRequest: URLRequest = URLRequest(url: URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=TCmkGAe5GGdkPznMj33vGGwJxv8rQ3np")!)
    
    init(remoteService: RemoteService = .shared) {
        self.remoteService = remoteService
    }
    
    
    func getMostPopularArticles(completion: @escaping (ArticlesResponse?, Error?) -> Void) {
        _ = remoteService.dispatch(mostPopularRequest) { (result: Result<ArticlesResponse, Error>) in
            do {
                let articleResponse = try result.get()
                completion(articleResponse, nil)
            } catch let error {
                completion(nil, error)
            }
        }
    }
}
