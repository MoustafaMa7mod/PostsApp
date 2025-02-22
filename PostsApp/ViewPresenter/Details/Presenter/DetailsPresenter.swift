//
//  DetailsPresenter.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import UIKit
import OSLog

protocol DetailsPresenterProtocol {
    
    var view: DetailsViewProtocol? { get set }
    var postID: Int { get set }
    var interactor: PostDetailsInteractor { get set }
    var isLiked: Bool { get }
    
    func viewDidLoad()
    func likedAndDisLikedTapped()
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    // MARK: - Properties
    weak var view: DetailsViewProtocol?
    var interactor: PostDetailsInteractor
    var postID: Int
    var isLiked: Bool = false
    
    init(
        view: DetailsViewProtocol? = nil,
        interactor: PostDetailsInteractor,
        postID: Int
    ) {
        self.view = view
        self.postID = postID
        self.interactor = interactor
    }
   
    func viewDidLoad() {
        checkPostLikeOrNot()
    }
}

// MARK: - Private Methods
extension DetailsPresenter {
    
    func likedAndDisLikedTapped() {
        
        Task(priority: .background) {
            do {
                isLiked = try await addLikeAndDislikeToPost()
                await view?.updateNavigationIcon()
            } catch let error {
                await view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    private func addLikeAndDislikeToPost() async throws -> Bool {
        
        guard var updatePost = await fetchFromLocal() else { return false }
        
        if updatePost.like {
            updatePost.like.toggle()
            // remove like
            return !(try await interactor.likePost(post: updatePost))
        } else {
            updatePost.like.toggle()
            // add like
            return try await interactor.likePost(post: updatePost)
        }
    }
    
    private func fetchFromLocal() async -> PostModel? {
        let result = await interactor.fetchPosts()
        return result.filter { $0.id == postID }.first
    }
    
    private func checkPostLikeOrNot() {
        
        Task(priority: .background) {
            
            if let post = await fetchFromLocal() {
                isLiked = post.like
                await view?.showPostData(post)
                await view?.updateNavigationIcon()
            }
        }
    }
}
