//
//  MostPopularView.swift
//  NYMostPopularArticles
//
//  Created by Mahmoud Abolfotoh on 04/12/2020.
//

import Foundation

protocol MostPopularView {
    func presentArticles(_ articles: [Article])
    func presentEmptyView()
}
