//
//  DetailsPresenter.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import UIKit

protocol DetailsPresenterProtocol {
    
    var view: DetailsViewProtocol? { get set }
    var post: PostModel { get set }
    
    func viewDidLoad()
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    // MARK: - Properties
    weak var view: DetailsViewProtocol?
    var post: PostModel
    
    init(view: DetailsViewProtocol? = nil, post: PostModel) {
        self.post = post
    }
   
    func viewDidLoad() {
        view?.showTitle(post.title)
        view?.showDescription(post.description)
    }
}
