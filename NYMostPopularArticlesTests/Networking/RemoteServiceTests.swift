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
    
    func setUpMockSession() -> URLSessionMock {
        let url = URL(string: "www.apple.com")!
        let session = URLSessionMock()
        session.testData = "".data(using: .utf8)
        session.testReponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        return session
    }
}
