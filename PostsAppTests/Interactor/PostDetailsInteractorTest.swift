//
//  PostDetailsInteractorTest.swift
//  PostsAppTests
//
//  Created by Moustafa on 24/02/2025.
//

import XCTest
@testable import PostsApp
@testable import NetworkLayer

final class PostDetailsInteractorTest: XCTestCase {
    
    var interactor: PostDetailsInteractor!
    var mockLocal: MockPostsLocal!
    
    override func setUp() {
        super.setUp()
        mockLocal = MockPostsLocal()
        interactor = PostDetailsInteractor(local: mockLocal)
    }
    
    override func tearDown() {
        interactor = nil
        mockLocal = nil
        super.tearDown()
    }
    
    func test_fetchPosts_returnsLocalPosts() async {
        mockLocal.storedPosts = mockLocal.posts()
        
        let result = await interactor.fetchPosts()
        XCTAssertEqual(result.count, mockLocal.storedPosts.count)
    }
    
    func test_likePost_updatesPostSuccessfully() async throws {
        mockLocal.storedPosts = mockLocal.posts()
        
        let updatedPost = PostModel(
            id: 1,
            title: "post title",
            description: "post body",
            like: true
        )
        
        let result = try await interactor.likePost(post: updatedPost)
        
        // Then
        XCTAssertTrue(result)
        XCTAssertTrue(mockLocal.isUpdate)
        XCTAssertEqual(mockLocal.storedPosts.first?.like, true)
    }
}
