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
    
    // MARK: - Methods
    init(remote: PostsRemoteAPIProtocol) {
        self.remote = remote
    }
    
    func fetchPosts() async throws -> [PostModel] {
        let result = try await remote.fetchPosts()
        
        return result.map { $0.toEntity() }
    }
}
