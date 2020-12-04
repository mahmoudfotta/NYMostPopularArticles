//
//  Article.swift
//  NYMostPopularArticles
//
//  Created by Mahmoud Abolfotoh on 04/12/2020.
//

import Foundation

struct Article: Decodable {
    var title: String?
    var byline: String?
    var publishedDate: String?
    var subsection: String?
    var abstract: String?
    
    enum CodingKeys: String, CodingKey {
        case title, byline, subsection, abstract
        case publishedDate = "published_date"
    }
}
