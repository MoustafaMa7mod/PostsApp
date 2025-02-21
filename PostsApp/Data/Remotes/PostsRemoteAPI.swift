//
//  PostsRemoteAPI.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import NetworkLayer

protocol PostsRemoteAPI {
    func fetchPosts() async throws -> [PostDataModel]
}

class DefaultPostsRemoteAPI: PostsRemoteAPI {
    
    // MARK: - Properties
    private var networkService: NetworkService
    
    // MARK: - Methods
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchPosts() async throws -> [PostDataModel] {
        
        let result: [PostDataModel] = try await networkService.fetchData(query: "")
        
        return result
    }
}
