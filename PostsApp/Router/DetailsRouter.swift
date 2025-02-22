//
//  HomeRouter.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import NetworkLayer
import UIKit

class DetailsRouter {
    
    // MARK: - Properties
    private weak var navigationController: CustomNavigationController?
    
    // MARK: - Methods
    init(navigationController: CustomNavigationController?) {
        self.navigationController = navigationController
    }
    
    func navigateToDetailView(with post: PostModel) {
        let detailsView = DetailsView()
        let local = PostsLocal()
        let interactor = PostDetailsInteractor(local: local)
        
        let presenter = DetailsPresenter(
            view: detailsView,
            interactor: interactor,
            postID: post.id
        )
        
        detailsView.presenter = presenter
        navigationController?.pushViewController(detailsView, animated: true)
    }
}
