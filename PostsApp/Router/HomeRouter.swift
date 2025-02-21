//
//  HomeRouter.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import NetworkLayer
import UIKit

class HomeRouter {
    
    // MARK: - Properties
    private var window: UIWindow
    private var navigationController: UINavigationController
    
    // MARK: - Methods
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func createHomeView() {
        
        let networkService = NetworkService(
            baseURL: ConfigurationManager.shared.baseURL
        )
        let remote = PostsRemoteAPI(networkService: networkService)
        let interactor = GetPostsInteractor(remote: remote)
        let presenter = GetPostsPresenter(interactor: interactor)
        let homeView = HomeView()
        homeView.presenter = presenter
        navigationController = UINavigationController(rootViewController: homeView)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
