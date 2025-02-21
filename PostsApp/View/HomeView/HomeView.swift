//
//  ViewController.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import UIKit

class HomeView: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var presenter: GetPostsPresenterProtocol?
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
//        loadData()
    }
}

// MARK: - Private Methods
extension HomeView {
    
    private func loadData() {
        
        Task(priority: .background) {
            do {
                let result = try await presenter?.fetchPosts()
                
                print("DEBUG: result \(result)")
            } catch let error {
                print("DEBUG: error \(error.localizedDescription)")
            }
        }
    }
    
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: HomeViewCell.self)
        tableView.tableFooterView = UIView()
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: HomeViewCell = tableView.dequeueReusableCell() else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis aliquid molestiae\nperspiciatis et ea nemo ab reprehenderit accusantium quas\nvoluptate dolores velit et doloremque molestiae"
        
        cell.descriptionLabel.text = "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis aliquid molestiae\nperspiciatis et ea nemo ab reprehenderit accusantium quas\nvoluptate dolores velit et doloremque molestiae"
        
        return cell
    }
}
