//
//  ArticlesResponse.swift
//  NYMostPopularArticles
//
//  Created by Mahmoud Abolfotoh on 04/12/2020.
//

import Foundation

struct ArticlesResponse: Decodable {
    var articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case articles = "results"
    }
}
