//
//  ViewController.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    
    var presenter: HomePresenterProtocol? { get set }
    
    func showLoading()
    @MainActor func loadTableView()
}

class HomeView: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    var presenter: HomePresenterProtocol?
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        setupTableView()
        setupActivityIndicator()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Private Methods
extension HomeView {
    
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: HomeViewCell.self)
        tableView.tableFooterView = UIView()
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
}


// MARK: - HomeViewProtocol
extension HomeView: HomeViewProtocol {
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    @MainActor
    func loadTableView() {
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: HomeViewCell = tableView.dequeueReusableCell() else {
            
            return UITableViewCell()
        }
        
        presenter?.itemForCell(cell: cell, at: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.navigateToDetailView(with: indexPath.row)
    }
    
    /// Detects when the user scrolls near the bottom of the table view and triggers pagination.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y // Current vertical scroll position
        let contentHeight = scrollView.contentSize.height // Total content height
        let tableViewHeight = scrollView.frame.size.height // Visible table view height
        
        // Check if the user has scrolled close to the bottom (100 points before the end)
        if offsetY > contentHeight - tableViewHeight - 100 {
            Task(priority: .background) {
                await presenter?.loadMoreData()
            }
            
        }
    }
}
