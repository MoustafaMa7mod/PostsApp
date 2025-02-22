//
//  DetailsViewViewController.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    
    var presenter: DetailsPresenterProtocol? { get set }
    
    @MainActor func showPostData(_ post: PostModel)
    @MainActor func updateNavigationIcon()
    @MainActor func showError(message: String)
}

class DetailsView: UIViewController, DetailsViewProtocol {

    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    var presenter: DetailsPresenterProtocol?
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        presenter?.viewDidLoad()
    }
}

// MARK: - Private Methods
extension DetailsView {
    
    @objc private func likedAndDisLikedButtonTapped() {
        presenter?.likedAndDisLikedTapped()
    }
}

// MARK: - Details View Protocol
extension DetailsView {
    
    @MainActor
    func showPostData(_ post: PostModel) {
        titleLabel.text = post.title
        descriptionLabel.text = post.description
    }
    
    @MainActor
    func updateNavigationIcon() {
        let isLiked = presenter?.isLiked ?? false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: isLiked ? "favorite" : "unfavorite"),
            style: .plain,
            target: self,
            action: #selector(likedAndDisLikedButtonTapped)
        )
    }

    @MainActor
    func showError(message: String) {
        showAlert(message: message)
    }
}
