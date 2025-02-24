//
//  PostsLocalTest.swift
//  PostsAppTests
//
//  Created by Moustafa on 24/02/2025.
//

import XCTest
@testable import PostsApp

final class PostsLocalTest: XCTestCase {

    var persistenceController: PersistenceController!
    var local: PostsLocalProtocol!
    
    override func setUp() {
        super.setUp()
        persistenceController = PersistenceController(inMemory: true)
        local = PostsLocal(persistenceController: persistenceController)
    }
    
    override func tearDown() {
        persistenceController = nil
        local = nil
        super.tearDown()
    }

    func testSavePost_Success() async {
                
        await local.save(item: postItem())
                
        let fetchLocalPosts = await local.fetchPosts()
        
        XCTAssertEqual(fetchLocalPosts.count, 1)
        XCTAssertEqual(fetchLocalPosts.first?.title, "post title")
    }
    
    func testFetchPosts_Empty() async {
        
        let fetchLocalPosts = await local.fetchPosts()
        
        XCTAssertTrue(fetchLocalPosts.isEmpty)
    }
    
    func testDeletePosts_Success() async {
        
        await local.save(item: postItem())
        
        var fetchLocalPosts = await local.fetchPosts()
        XCTAssertEqual(fetchLocalPosts.count, 1)
        
        await local.clearData()
        
        fetchLocalPosts = await local.fetchPosts()
        XCTAssertTrue(fetchLocalPosts.isEmpty)
    }
    
    func testUpdatePost_Success() async {
        var item = postItem()
        await local.save(item: item)
        
        if let post = await local.fetchPosts().first {
            XCTAssertFalse(post.like)
        }
        
        item.like = true
        
        let result = await local.updatePost(item: item)
        
        XCTAssertTrue(result)
        if let post = await local.fetchPosts().first {
            XCTAssertTrue(post.like)
        }
    }
    
    private func postItem() -> PostModel {
        PostModel(
            id: 1,
            title: "post title",
            description: "post body",
            like: false
        )
    }
}
