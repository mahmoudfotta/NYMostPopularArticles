//
//  RemoteServiceTestHelper.swift
//  NYMostPopularArticlesTests
//
//  Created by Mahmoud Abolfotoh on 05/12/2020.
//

import Foundation
@testable import NYMostPopularArticles

class DataTaskMock: URLSessionDataTask {
    private let completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    override func resume() {
        completion()
    }
}

class URLSessionMock: URLSessionProtocol {
    var testData: Data?
    var testReponse: URLResponse?
    var testError: Error?
    var lastRequest: URLRequest?
    
    func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        lastRequest = url
        let testData = self.testData
        let testReponse = self.testReponse
        let testError = self.testError
        return DataTaskMock {
            completionHandler(testData, testReponse, testError)
        }
    }
}
