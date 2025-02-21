//
//  HomeRouter.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import NetworkLayer
import UIKit

class HomeRouter {
        
    static func createHomeView() -> HomeView {
        
        let networkService = NetworkService(
            baseURL: ConfigurationManager.shared.baseURL
        )
        
        let remote = PostsRemoteAPI(networkService: networkService)
        let interactor = GetPostsInteractor(remote: remote)
        let presenter = HomePresenter()
        let homeView = HomeView(nibName: HomeView.nibName, bundle: nil)
        presenter.interactor = interactor
        presenter.view = homeView
        homeView.presenter = presenter
        
        return homeView
    }
}
