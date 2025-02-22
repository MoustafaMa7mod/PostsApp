//
//  SplashPresenter.swift
//  PostsApp
//
//  Created by Moustafa on 22/02/2025.
//

protocol SplashPresenterProtocol {
    
    var view: SplashViewProtocol? { get set }
    
    func navigateToHomeView()
}

class SplashPresenter: SplashPresenterProtocol {
    
   
    // MARK: - Properties
    weak var view: SplashViewProtocol?
    var router: HomeRouter?
    
    init(
        view: SplashViewProtocol? = nil,
        router: HomeRouter? = nil
    ) {
        self.view = view
        self.router = router
    }
    
    func navigateToHomeView() {
        router?.navigateToHomeView()
    }
}
