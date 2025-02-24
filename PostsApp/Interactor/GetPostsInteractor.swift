//
//  GetPostsInteractor.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import OSLog

protocol GetPostsInteractorProtocol {
    func fetchPosts() async throws -> [PostModel]
    func updatePosts() async throws
}

class GetPostsInteractor: GetPostsInteractorProtocol {
    
    // MARK: - Properties
    private let remote: PostsRemoteAPIProtocol
    private let local: PostsLocalProtocol
    
    // MARK: - Methods
    init(remote: PostsRemoteAPIProtocol, local: PostsLocalProtocol) {
        self.remote = remote
        self.local = local
    }
    
    func fetchPosts() async throws -> [PostModel] {
        
        let localPosts = await local.fetchPosts()
        if !localPosts.isEmpty {
            return localPosts
        }
        
        let remotePosts = try await remote.fetchPosts().map { $0.toEntity() }

        for item in remotePosts {
            await local.save(item: item)
        }
        
        return remotePosts
    }
    
    func updatePosts() async {
        do {
            let result = try await remote.fetchPosts().map { $0.toEntity() }
            await local.clearData()

            for item in result {
                await local.save(item: item)
            }
        } catch let error {
            Logger().error("\(error.localizedDescription)")
        }
    }
}
