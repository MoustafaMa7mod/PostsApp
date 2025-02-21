//
//  UITableView+Extensions.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import UIKit
import Foundation

extension UITableView {
    
    func register<T: UITableViewCell>(cellType: T.Type) {
        let nib = UINib(nibName: cellType.nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cellType.nibName)
    }

    func dequeueReusableCell<T: UITableViewCell>() -> T? {
        let cell = self.dequeueReusableCell(withIdentifier: T.nibName)
        return cell as? T
    }
}
