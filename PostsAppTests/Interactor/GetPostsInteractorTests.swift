//
//  GetPostsInteractorTests.swift
//  PostsAppTests
//
//  Created by Moustafa on 24/02/2025.
//

import XCTest
@testable import PostsApp
@testable import NetworkLayer

final class GetPostsInteractorTests: XCTestCase {
    
    var interactor: GetPostsInteractor!
    var mockRemote: MockPostsRemoteAPI!
    var mockLocal: MockPostsLocal!
    
    override func setUp() {
        super.setUp()
        mockRemote = MockPostsRemoteAPI()
        mockLocal = MockPostsLocal()
        interactor = GetPostsInteractor(remote: mockRemote, local: mockLocal)
    }
    
    override func tearDown() {
        interactor = nil
        mockRemote = nil
        mockLocal = nil
        super.tearDown()
    }
    
    func test_fetchPosts_returnsLocalData_whenAvailable() async throws {
        let localPosts = mockRemote.posts().map{ $0.toEntity() }
        mockLocal.storedPosts = localPosts
        
        
        let posts = try await interactor.fetchPosts()
        
        XCTAssertEqual(posts.count, localPosts.count)
        XCTAssertTrue(mockLocal.fetchPostsCalled)
    }
    
    func test_fetchPosts_fetchesFromRemote_whenLocalIsEmpty() async throws {
        
        let posts = try await interactor.fetchPosts()
        
        XCTAssertEqual(posts.count, 2)
        XCTAssertEqual(posts.first?.id, 1)
        XCTAssertTrue(mockLocal.saveCalled)
    }
    
    func test_updatePosts_clearsLocalAndSavesNewData() async {
        await interactor.updatePosts()
        
        XCTAssertTrue(mockLocal.clearDataCalled)
        XCTAssertTrue(mockLocal.saveCalled)
        XCTAssertEqual(mockLocal.storedPosts.count, 2)
    }
    
    func test_updatePosts_logsErrorOnFailure() async {
        
        mockRemote.error = .requestFailed
        
        do {
            _ = try await interactor.fetchPosts()
            XCTFail("Expected an error but got success")
        } catch let error as APIError {
            XCTAssertEqual(error, .requestFailed)
            XCTAssertFalse(mockLocal.saveCalled)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
