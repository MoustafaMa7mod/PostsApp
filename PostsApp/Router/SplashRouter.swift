//
//  SplashRouter.swift
//  PostsApp
//
//  Created by Moustafa on 22/02/2025.
//

import NetworkLayer
import UIKit

class SplashRouter {
    
    // MARK: - Properties
    private weak var window: UIWindow?
    private weak var navigationController: CustomNavigationController?
    
    // MARK: - Methods
    init(
        window: UIWindow? = nil,
        navigationController: CustomNavigationController? = nil
    ) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func createSplashView() {
        
        let splashView = SplashView()
        let homeRouter = HomeRouter(
            window: window,
            navigationController: navigationController
        )
        let presenter = SplashPresenter(
            view: splashView,
            router: homeRouter
        )
        splashView.presenter = presenter
        window?.rootViewController = splashView
        window?.makeKeyAndVisible()
    }
}
