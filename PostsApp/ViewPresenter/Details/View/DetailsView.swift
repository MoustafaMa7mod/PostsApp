//
//  DetailsViewViewController.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import UIKit

protocol DetailsViewwProtocol: AnyObject {
    
    var presenter: DetailsPresenterProtocol? { get set }
}

class DetailsView: UIViewController, DetailsViewwProtocol {

    var presenter: DetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
