//
//  RemoteServiceTests.swift
//  NYMostPopularArticlesTests
//
//  Created by Mahmoud Abolfotoh on 05/12/2020.
//

import XCTest
@testable import NYMostPopularArticles

class RemoteServiceTests: XCTestCase {
    var url: URL!
    var request: URLRequest!
    var session: URLSessionMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        url = URL(string: "www.apple.com")
        request = URLRequest(url: url)
        session = setUpMockSession()
    }

    override func tearDownWithError() throws {
        url = nil
        request = nil
        session = nil
        try super.tearDownWithError()
    }

    func testRemoteServiceDispatchFetchesFromCorrectURL() throws {
        //given
        let remoteService = RemoteService(session: session, responseQueue: .main)
        let expectation = XCTestExpectation(description: "fetch from correct url www.apple.com")
        
        //when
        _ = remoteService.dispatch(request) { (result: Result<String, Error>) in
            XCTAssertEqual(self.session.lastRequest?.url, self.url)
            expectation.fulfill()
        }
        
        //then
        wait(for: [expectation], timeout: 1)
    }
    
    func testRemoteServiceDispatchCallsDataTaskResume() throws {
        //given
        let remoteService = RemoteService(session: session, responseQueue: .main)
        let expectation = XCTestExpectation(description: "calling remoteservice dispatch triggers resume().")
        
        //when
        _ = remoteService.dispatch(request, completionHandler: { (result: Result<String, Error>) in
            XCTAssertTrue(self.session.dataTask?.resumeWasCalled ?? false)
            expectation.fulfill()
        })
        
        //then
        wait(for: [expectation], timeout: 1)
    }
    
    func testRemoteServiceDispatchReturnsCorrectJSONData() throws {
        //given
        let remoteService = RemoteService(session: session, responseQueue: .main)
        let expectation = XCTestExpectation(description: "calling remoteservice dispatch returns correct JSON data")
        
        //when
        _ = remoteService.dispatch(request, completionHandler: { (result: Result<ArticlesResponse, Error>) in
            XCTAssertNotNil(try? result.get())
            expectation.fulfill()
        })
        
        //then
        wait(for: [expectation], timeout: 1)
    }
    
    func testRemoteServiceDispatchCompletionHandlerReturnsInCorrectDispatchQueue() throws {
        //given
        let remoteService = RemoteService(session: session, responseQueue: .main)
        let expectation = XCTestExpectation(description: "remoteservice dispatch completion handler returns in main queue")
        
        //when
        _ = remoteService.dispatch(request, completionHandler: { (result: Result<ArticlesResponse, Error>) in
            XCTAssertTrue(Thread.isMainThread)
            expectation.fulfill()
        })
        
        //then
        wait(for: [expectation], timeout: 1)
    }
    
    func testRemoteServiceDispatchReturnsError() throws {
        //given
        let error = NSError(domain: "", code: 500, userInfo: nil)
        let session = setUpMockSession(error: error)
        let remoteService = RemoteService(session: session, responseQueue: .main)
        let expectation = XCTestExpectation(description: "calling remoteservice dispatch returns correct JSON data")
        
        //when
        _ = remoteService.dispatch(request, completionHandler: { (result: Result<ArticlesResponse, Error>) in
            switch result {
            case let .success(articlesResponse):
                XCTAssertNil(articlesResponse)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        })
        
        //then
        wait(for: [expectation], timeout: 1)
    }
    
    func setUpMockSession(error: Error? = nil) -> URLSessionMock {
        let testData = """
            {
                "status": "OK",
                "results": [
                    {
                        "published_date": "2020-12-04",
                        "updated": "2020-12-04 22:47:07",
                        "subsection": "Sunday Review",
                        "byline": "By Nicholas Kristof",
                        "title": "The Children of Pornhub",
                        "abstract": "Why does Canada allow this company to profit off videos of exploitation and assault?"
                    }
                ]
            }
            """.data(using: .utf8)
        let url = URL(string: "www.apple.com")!
        let session = URLSessionMock()
        session.testData = testData
        session.testReponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        session.testError = error
        return session
    }
}


