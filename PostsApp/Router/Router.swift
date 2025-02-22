//
//  HomeRouter.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import NetworkLayer
import UIKit

class Router {
    
    // MARK: - Properties
    private var window: UIWindow
    private var navigationController: UINavigationController
    
    // MARK: - Methods
    init(window: UIWindow, navigationController: CustomNavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func createHomeView() {
        
        let networkService = NetworkService(
            baseURL: ConfigurationManager.shared.baseURL
        )
        let remote = PostsRemoteAPI(networkService: networkService)
        let local = PostsLocal()
        let interactor = GetPostsInteractor(remote: remote, local: local)
        let homeView = HomeView()
        let presenter = HomePresenter(
            view: homeView,
            router: self,
            interactor: interactor
        )
        homeView.presenter = presenter
        navigationController = CustomNavigationController(rootViewController: homeView)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func navigateToDetailView(with post: PostModel) {
        
        let detailsView = DetailsView()
        let presenter = DetailsPresenter(view: detailsView,  post: post)
        presenter.view = detailsView
        detailsView.presenter = presenter
        navigationController.pushViewController(detailsView, animated: true)
    }
}
