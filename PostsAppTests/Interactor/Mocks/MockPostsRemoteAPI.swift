//
//  MockPostsRemoteAPI.swift
//  PostsApp
//
//  Created by Moustafa on 24/02/2025.
//

@testable import PostsApp
@testable import NetworkLayer

class MockPostsRemoteAPI: PostsRemoteAPIProtocol {
    
    
    var error: APIError?


    func fetchPosts() async throws -> [PostDataModel] {
        
        if let error = error {
            throw error
        }
    
        return posts()
    }
}
