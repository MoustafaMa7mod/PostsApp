//
//  DetailsPresenter.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import UIKit

protocol DetailsPresenterProtocol {
    
    var view: DetailsViewwProtocol? { get set }
    var post: PostModel { get set }
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    // MARK: - Properties
    weak var view: DetailsViewwProtocol?
    var post: PostModel
    
    init(post: PostModel) {
        self.post = post
    }
   
}
