//
//  NSObject+Extenion.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import Foundation

extension NSObject {
    
    static var nibName: String {
        return String(describing: self)
    }
}
