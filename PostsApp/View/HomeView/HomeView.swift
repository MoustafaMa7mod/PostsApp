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
        loadData()
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
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}
