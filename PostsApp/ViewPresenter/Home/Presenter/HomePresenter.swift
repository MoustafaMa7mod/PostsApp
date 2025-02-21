//
//  GetPostsPresenter.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import UIKit

protocol HomePresenterProtocol {
    
    var view: HomeViewProtocol? { get set }
    var interactor: GetPostsInteractorProtocol? { get set }
    
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func itemForCell(cell: HomeViewCellProtocol, at indexPath: Int)
}

class HomePresenter: HomePresenterProtocol {
    
    // MARK: - Private Properties
    private var posts: [PostModel] = []
    
    // MARK: - Properties
    var view: HomeViewProtocol?
    var interactor: GetPostsInteractorProtocol?
    
    // MARK: - Get Posts Presenter Protocol Functions
    func viewDidLoad() {
        
        view?.showLoading()
        
        Task(priority: .background) {
            
            do {
                posts = try await fetchPosts()
                await view?.loadTableView()
            } catch {
                print("Failed to fetch posts: \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        posts.count
    }

    func itemForCell(cell: HomeViewCellProtocol, at indexPath: Int) {
        let model = posts[indexPath]
        cell.display(title: model.title)
        cell.display(description: model.description)
    }
}

// MARK: - Private Functions

extension HomePresenter {
    
    
    private func fetchPosts() async throws -> [PostModel] {
        try await interactor?.fetchPosts() ?? []
    }
}
