//
//  HomePresenterTestsTests.swift
//  PostsAppTests
//
//  Created by Moustafa on 24/02/2025.
//

import XCTest
@testable import PostsApp

final class HomePresenterTestsTests: XCTestCase {

    var presenter: HomePresenter!
    var mockView: MockHomeView!
    var mockInteractor: MockGetPostsInteractor!
    var mockRouter: MockDetailsRouter!

    override func setUp() {
        super.setUp()
        mockView = MockHomeView()
        mockInteractor = MockGetPostsInteractor()
        mockRouter = MockDetailsRouter()
        presenter = HomePresenter(
            view: mockView,
            router: mockRouter,
            interactor: mockInteractor
        )
        mockView.presenter = presenter
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }
    
    func test_viewDidLoad_callsLoadData() async {
        
        do {
            try await presenter.fetchPosts()
            XCTAssertTrue(mockInteractor.isFetchPosts)
            XCTAssertFalse(presenter.posts.isEmpty)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_numberOfRowsInSection_returnsCorrectCount() {
        presenter.displayedPosts = mockInteractor.posts()
        
        let count = presenter.numberOfRowsInSection()
        
        XCTAssertEqual(count, 2)
    }

    func test_loadMoreData_appendsMorePosts() async {
        presenter.posts = (1...15).map {
            PostModel(
                id: $0,
                title: "Post \($0)",
                description: "Desc \($0)",
                like: false
            )
        }
        presenter.displayedPosts = Array(presenter.posts.prefix(10))
        presenter.currentPage = 1
        
        await presenter.loadMoreData()
        
        XCTAssertEqual(presenter.displayedPosts.count, 15)
        XCTAssertTrue(mockView.isLoadTableView)
    }
    
}
