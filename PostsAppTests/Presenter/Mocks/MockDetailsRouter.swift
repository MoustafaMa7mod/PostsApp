//
//  MockDetailsRouter.swift
//  PostsApp
//
//  Created by Moustafa on 24/02/2025.
//

@testable import PostsApp

class MockDetailsRouter: DetailsRouterProtocol {
    
    var isNavigateToDetailView = false
    var post: PostModel?
    
    func navigateToDetailView(with post: PostModel) {
        isNavigateToDetailView = true
        self.post = post
    }
}
