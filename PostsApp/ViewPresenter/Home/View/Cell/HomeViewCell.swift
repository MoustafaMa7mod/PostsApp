//
//  HomeViewCell.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import UIKit

protocol HomeViewCellProtocol {
    func display(title: String)
    func display(description: String)
}

class HomeViewCell: UITableViewCell, HomeViewCellProtocol {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Home View Cell Protocol
    func display(title: String) {
        titleLabel.text = title
    }
    
    func display(description: String) {
        descriptionLabel.text = description
    }
}
