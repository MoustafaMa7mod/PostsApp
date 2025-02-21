//
//  GetPostsPresenter.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

protocol GetPostsPresenterProtocol {
    func fetchPosts() async throws -> [PostDataModel]
}

class GetPostsPresenter: GetPostsPresenterProtocol {
    
    let interactor: GetPostsInteractorProtocol
    
    init(interactor: GetPostsInteractorProtocol) {
        self.interactor = interactor
    }
    
    func fetchPosts() async throws -> [PostDataModel] {
        try await interactor.fetchPosts()
    }
}
