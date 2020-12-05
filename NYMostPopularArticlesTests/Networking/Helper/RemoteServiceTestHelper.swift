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
    var resumeWasCalled = false
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    override func resume() {
        resumeWasCalled = true
        completion()
    }
}

class URLSessionMock: URLSessionProtocol {
    var testData: Data?
    var testReponse: URLResponse?
    var testError: Error?
    var lastRequest: URLRequest?
    var dataTask: DataTaskMock?
    
    func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        lastRequest = url
        let testData = self.testData
        let testReponse = self.testReponse
        let testError = self.testError
        dataTask = DataTaskMock {
            completionHandler(testData, testReponse, testError)
        }
        
        return dataTask!
    }
}
