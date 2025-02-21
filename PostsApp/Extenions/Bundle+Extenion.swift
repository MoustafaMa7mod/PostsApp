//
//  Bundle+Extenion.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import Foundation

/// An extension of `Bundle` that provides a helper method for retrieving values from the Info.plist file.
extension Bundle {
    
    /// Retrieves a value from the app's Info.plist file for a given key.
    /// - Parameter key: The key corresponding to the value in the Info.plist.
    /// - Returns: A `String` containing the value if found, otherwise `nil`.
    ///
    func getValueFromInfoPlist(forKey key: String) -> String? {
        return self.infoDictionary?[key] as? String
    }
}
