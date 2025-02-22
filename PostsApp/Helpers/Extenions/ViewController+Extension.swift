//
//  ViewController+Extension.swift
//  PostsApp
//
//  Created by Moustafa on 22/02/2025.
//

import UIKit

extension UIViewController {
    
    func showAlert(message: String) {
        let alertController = UIAlertController(
            title: "Alert",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
