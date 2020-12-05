//
//  RemoteServiceTests.swift
//  NYMostPopularArticlesTests
//
//  Created by Mahmoud Abolfotoh on 05/12/2020.
//

import XCTest
@testable import NYMostPopularArticles

class RemoteServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRemoteServiceDispatchFetchesFromCorrectURL() throws {
        //given
        let url = URL(string: "www.apple.com")!
        let request = URLRequest(url: url)
        let session = setUpMockSession()
        let remoteService = RemoteService(session: session, responseQueue: .main)
        let expectation = XCTestExpectation(description: "fetch from correct url www.apple.com")
        
        //when
        _ = remoteService.dispatch(request) { (result: Result<ArticlesResponse, Error>) in
            XCTAssertEqual(session.lastRequest?.url, url)
            expectation.fulfill()
        }
        
        //then
        wait(for: [expectation], timeout: 1)
    }
    
    func setUpMockSession() -> URLSessionMock {
        let url = URL(string: "www.apple.com")!
        let session = URLSessionMock()
        session.testData = "".data(using: .utf8)
        session.testReponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        return session
    }
}
