//
//  HomeRouter.swift
//  PostsApp
//
//  Created by Moustafa on 23/02/2025.
//

import NetworkLayer
import UIKit

class HomeRouter {
    
    // MARK: - Properties
    private weak var window: UIWindow?
    private weak var navigationController: CustomNavigationController?
    
    // MARK: - Methods
    init(window: UIWindow? = nil, navigationController: CustomNavigationController? = nil) {
        self.window = window
        self.navigationController = navigationController
    }

    func navigateToHomeView() {
        
        let networkService = NetworkService(
            baseURL: ConfigurationManager.shared.baseURL
        )
        let remote = PostsRemoteAPI(networkService: networkService)
        let local = PostsLocal()
        let interactor = GetPostsInteractor(remote: remote, local: local)
        let homeView = HomeView()
        let navigationController = CustomNavigationController(rootViewController: homeView)
        self.navigationController = navigationController

        let homeRouter = DetailsRouter(navigationController: self.navigationController)

        let presenter = HomePresenter(
            view: homeView,
            router: homeRouter,
            interactor: interactor
        )
        homeView.presenter = presenter
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
