//
//  MockGetPostsInteractor.swift
//  PostsApp
//
//  Created by Moustafa on 24/02/2025.
//

@testable import PostsApp

class MockGetPostsInteractor: GetPostsInteractorProtocol {
    
    var isFetchPosts = false
    var isUpdatePosts = false

    func fetchPosts() async throws -> [PostModel] {
        isFetchPosts = true
        return posts()
    }

    func updatePosts() async throws {
        isUpdatePosts = true
    }
}
