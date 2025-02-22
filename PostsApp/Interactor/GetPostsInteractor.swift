//
//  GetPostsInteractor.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

protocol GetPostsInteractorProtocol {
    func fetchPosts() async throws -> [PostModel]
}

class GetPostsInteractor: GetPostsInteractorProtocol {
    
    // MARK: - Properties
    private let remote: PostsRemoteAPIProtocol
    private let local: PostsLocal
    
    // MARK: - Methods
    init(remote: PostsRemoteAPIProtocol, local: PostsLocal) {
        self.remote = remote
        self.local = local
    }
    
    func fetchPosts() async throws -> [PostModel] {
        let result = try await remote.fetchPosts()
        
        return result.map { $0.toEntity() }
    }
}
