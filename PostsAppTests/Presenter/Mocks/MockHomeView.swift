//
//  MockHomeView.swift
//  PostsApp
//
//  Created by Moustafa on 24/02/2025.
//

@testable import PostsApp

class MockHomeView: HomeViewProtocol {
    
    var presenter: HomePresenterProtocol?
    
    var isLoading = false
    var isLoadTableView = false
    var showErrorMessage: String?

    func showLoading() {
        isLoading = true
    }

    @MainActor
    func loadTableView() {
        isLoadTableView = true
    }

    @MainActor
    func showError(message: String) {
        showErrorMessage = message
    }
}

