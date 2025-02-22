//
//  SplashView.swift
//  PostsApp
//
//  Created by Moustafa on 22/02/2025.
//

import UIKit

protocol SplashViewProtocol: AnyObject {
    
    var presenter: SplashPresenterProtocol? { get set }
}

class SplashView: UIViewController, SplashViewProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    var presenter: SplashPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
    }
}

// MARK: - Private Methods

extension SplashView {
    
    private func setupAnimation() {
        
        if let gifImage = UIImage.gif(name: Constants.AnimationLogo.logo) {
            imageView.image = gifImage
            
            // Schedule an action when the GIF animation completes
            Timer.scheduledTimer(withTimeInterval: gifImage.duration, repeats: false) { [weak self] _ in
                guard let self else { return }
                self.gifDidFinish()
            }
        }
    }
    
    private func gifDidFinish() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.presenter?.navigateToHomeView()
        }
    }
}
