//
//  PostDetailsInteractor.swift
//  PostsApp
//
//  Created by Moustafa on 22/02/2025.
//

protocol PostDetailsInteractorProtocol: AnyObject {
     
    func likePost(post: PostModel) async throws -> Bool
    func fetchPosts() async -> [PostModel]
}

class PostDetailsInteractor: PostDetailsInteractorProtocol {
    
    // MARK: - Properties
    private let local: PostsLocal
    
    // MARK: - Methods
    init(local: PostsLocal) {
        self.local = local
    }
    
    func fetchPosts() async -> [PostModel] {
        await local.fetchPosts()
    }
    
    func likePost(post: PostModel) async throws -> Bool {
        await local.updatePost(item: post)
    }
}
