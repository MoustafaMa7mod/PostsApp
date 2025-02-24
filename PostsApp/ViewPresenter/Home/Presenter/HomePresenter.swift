//
//  GetPostsPresenter.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import UIKit

protocol HomePresenterProtocol {
    
    var view: HomeViewProtocol? { get set }
    var interactor: GetPostsInteractorProtocol { get set }
    var router: DetailsRouterProtocol? { get set }

    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func itemForCell(cell: HomeViewCellProtocol, at indexPath: Int)
    func navigateToDetailView(with indexPath: Int)
    func loadMoreData() async
}

class HomePresenter: HomePresenterProtocol {
    
    // MARK: - Private Properties
    var posts: [PostModel] = []
    var displayedPosts: [PostModel] = []
    var currentPage = 0
    private var isLoadMore = false
    private let pageSize = 10

    // MARK: - Properties
    weak var view: HomeViewProtocol?
    var router: DetailsRouterProtocol?
    var interactor: GetPostsInteractorProtocol
    
    init(
        view: HomeViewProtocol? = nil,
        router: DetailsRouterProtocol? = nil,
        interactor: GetPostsInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - Get Posts Presenter Protocol Functions
    func viewDidLoad() {
        
        loadData()
    }
    
    func numberOfRowsInSection() -> Int {
        displayedPosts.count
    }

    func itemForCell(cell: HomeViewCellProtocol, at indexPath: Int) {
        let model = displayedPosts[indexPath]
        cell.display(title: model.title)
        cell.display(description: model.description)
    }
    
    func navigateToDetailView(with indexPath: Int) {
        router?.navigateToDetailView(with: displayedPosts[indexPath])
    }
    
    /// Loads more data for pagination by appending the next batch of posts.
    func loadMoreData() async {
        // Prevent multiple simultaneous load requests
        guard !isLoadMore else { return }
        
        // Calculate the range for the next page of posts
        let nextPageStart = currentPage * pageSize
        let nextPageEnd = nextPageStart + pageSize
        
        // Ensure there are more posts available to load
        guard nextPageStart < posts.count else { return }
        
        // Extract the next batch of posts within the available range
        let morePosts = Array(
            posts[nextPageStart..<min(nextPageEnd, posts.count)]
        )
        
        // Append the new posts to the displayed list
        displayedPosts.append(contentsOf: morePosts)
        
        // Increment the page counter
        currentPage += 1
        
        // Reset `isLoadMore` to allow future loading
        isLoadMore = false
        
        await view?.loadTableView()
    }
}

// MARK: - Private Methods
extension HomePresenter {
    
    private func loadData() {
        guard !isLoadMore else { return }
        isLoadMore = true
        view?.showLoading()
        
        Task(priority: .background) {
            do {
                try await fetchPosts()
            } catch {
                isLoadMore = false
                await view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func fetchPosts() async throws {
        posts = try await interactor.fetchPosts()
        isLoadMore = false
        await loadMoreData()
        try await interactor.updatePosts()
    }
}
