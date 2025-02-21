//
//  DetailsViewViewController.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    
    var presenter: DetailsPresenterProtocol? { get set }
    
    func showTitle(_ title: String)
    func showDescription(_ description: String)
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

// MARK: - Details View Protocol
extension DetailsView {
    
    func showTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func showDescription(_ description: String) {
        descriptionLabel.text = description
    }
}
