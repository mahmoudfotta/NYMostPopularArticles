//
//  MostPopularPresenterTests.swift
//  NYMostPopularArticlesTests
//
//  Created by Mahmoud Abolfotoh on 05/12/2020.
//

import XCTest
@testable import NYMostPopularArticles

class MostPopularPresenterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMostPopularPresenterInitSetsViewAndArticlesClient() throws {
        //given
        let presenter = MostPopularPresenter(view: MostPopularControllerMock(), articlesClient: ArticlesClientErrorMock())
        
        //then
        XCTAssertNotNil(presenter.view)
        XCTAssertNotNil(presenter.articlesClient)
    }
    
    func testMostPopularPresenterSuccessMockgetMostPopularArticlesMethodCallspresentArticles() {
        //given
        let view = MostPopularControllerMock()
        let client = ArticlesClientSuccessMock()
        let presenter = MostPopularPresenter(view: view, articlesClient: client)
        
        //when
        presenter.presentMostPopularArticles()
        
        //then
        XCTAssertTrue(view.presentArticlesCalled)
        XCTAssertFalse(view.presentEmptyCalled)
    }
    
    func testMostPopularPresenterErrorMockgetMostPopularArticlesMethodCallspresentEmptyView() {
        //given
        let view = MostPopularControllerMock()
        let client = ArticlesClientErrorMock()
        let presenter = MostPopularPresenter(view: view, articlesClient: client)
        
        //when
        presenter.presentMostPopularArticles()
        
        //then
        XCTAssertTrue(view.presentEmptyCalled)
        XCTAssertFalse(view.presentArticlesCalled)
    }
}
